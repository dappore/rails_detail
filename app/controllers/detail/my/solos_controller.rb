class Detail::My::SolosController < Detail::My::BaseController
  before_action :set_solo, only: [:edit, :update]

  def index
    @sort = Sort.find params[:sort_id]
    @solos = @sort.solos.order("id DESC")

    respond_to do |format|
      format.html
      format.json { render json: @solos }
    end
  end

  def new
    @sort = Sort.find params[:sort_id]
    if @sort.solos == []
      @solo = Solo.new
    else
      @solo = Solo.new(:content => @sort.solos.last.content||'',
                       :picture => @sort.solos.last.picture)
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @sort = Sort.find params[:sort_id]
    @solo = @sort.solos.build solo_params

    respond_to do |format|
      if @solo.save
        format.html { redirect_to @solo, notice: 'Solo was successfully created.' }
        format.js
        format.json { render json: @solo, status: :created, location: @solo }
      else
        format.html { render action: "new" }
        format.js
        format.json { render json: @solo.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @sort = Sort.find params[:sort_id]
    @solo = Solo.find(params[:id])

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @solo }
    end
  end

  def edit
    respond_to do |format|
      format.js
      format.html { render :layout => false }
    end
  end

  def update
    respond_to do |format|
      if @sort.update(sort_params)
        format.html { redirect_to :back, :notice => '更新成功' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sort.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @sort = Sort.find params[:sort_id]
    @solo = Solo.find(params[:id])
    @solo.destroy

    respond_to do |format|
      format.html { redirect_to solos_url }
      format.json { head :no_content }
    end
  end

  private
  def set_solo
    @solo = Solo.find params[:id]
  end

  def solo_params
    params[:solo].permit(:name, :subname, :content, :reason).merge(:user_id => current_user.id)
  end

end
