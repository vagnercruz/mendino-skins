# app/controllers/admin/skins_controller.rb
class Admin::SkinsController < Admin::BaseController
  before_action :set_skin, only: [ :show, :edit, :update, :destroy ]
  before_action :load_owner, only: [ :create, :update ] # Carrega o usuário dono antes de criar/atualizar

  # GET /admin/skins
  def index
    # Lista apenas as skins pertencentes ao dono do portfólio
    owner_id = ENV["PORTFOLIO_OWNER_USER_ID"]
    if owner_id
      @skins = Skin.where(user_id: owner_id).order(created_at: :desc)
    else
      @skins = [] # Ou mostre uma mensagem de erro/aviso
      flash.now[:alert] = "ID do dono do portfólio não configurado no .env (PORTFOLIO_OWNER_USER_ID)."
    end
  end

  # GET /admin/skins/:id
  def show
    # @skin é carregado pelo before_action :set_skin
  end

  # GET /admin/skins/new
  def new
    @skin = Skin.new
  end

  # POST /admin/skins
  def create
    @skin = Skin.new(skin_params)
    # Associa a skin ao dono do portfólio carregado
    @skin.user = @owner

    if @skin.save
      redirect_to admin_skin_path(@skin), notice: "Skin adicionada com sucesso."
    else
      flash.now[:alert] = "Erro ao adicionar skin: #{@skin.errors.full_messages.join(', ')}"
      render :new, status: :unprocessable_entity
    end
  end

  # GET /admin/skins/:id/edit
  def edit
    # @skin é carregado pelo before_action :set_skin
  end

  # PATCH/PUT /admin/skins/:id
  def update
    # Garante que a skin ainda pertença ao dono correto, mesmo que user_id esteja nos params
    if @skin.update(skin_params.merge(user: @owner))
      redirect_to admin_skin_path(@skin), notice: "Skin atualizada com sucesso."
    else
       flash.now[:alert] = "Erro ao atualizar skin: #{@skin.errors.full_messages.join(', ')}"
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/skins/:id
  def destroy
    @skin.destroy
    redirect_to admin_skins_url, notice: "Skin removida com sucesso.", status: :see_other
  end

  private

  def set_skin
    # Garante que estamos buscando apenas skins do dono do portfólio
    owner_id = ENV["PORTFOLIO_OWNER_USER_ID"]
    @skin = Skin.find_by!(id: params[:id], user_id: owner_id)
  rescue ActiveRecord::RecordNotFound
     redirect_to admin_skins_path, alert: "Skin não encontrada ou não pertence ao portfólio."
  end

  def load_owner
    owner_id = ENV["PORTFOLIO_OWNER_USER_ID"]
    unless owner_id
       redirect_to admin_skins_path, alert: "ID do dono do portfólio não configurado."
       return
    end
    @owner = User.find_by(id: owner_id)
    unless @owner
       redirect_to admin_skins_path, alert: "Usuário dono do portfólio (ID: #{owner_id}) não encontrado."
    end
  end

  # Strong Parameters: permite apenas os campos seguros do formulário
  def skin_params
    params.require(:skin).permit(
      :name, :weapon, :category, :wear_level, :float_value,
      :pattern_template, :image_url, :inspect_link, :price, :for_sale
    )
  end
end
