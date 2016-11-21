class Site::AttachmentsController < Site::BaseController
  layout 'site/media_library'
  before_action :set_breadcrumbs

  def index
    add_breadcrumb I18n.t('spina.website.documents'), site_attachments_path
    @attachments = Attachment.file_attached.sorted
    @attachment = Attachment.new
  end

  def create
    @attachment = Attachment.create(attachment_params)
  end

  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.destroy
    redirect_to spina.site_attachments_url
  end

  def select
    @attachments = Attachment.file_attached.sorted
    @attachment = Attachment.new
  end

  def insert
    @attachment = Attachment.find(params[:attachment_id])
  end

  def select_collection
    @attachments = Attachment.file_attached.sorted
    @attachment = Attachment.new
  end

  def insert_collection
    @attachments = Attachment.find(params[:attachment_ids])
  end

  private

  def set_breadcrumbs
    add_breadcrumb I18n.t('spina.website.media_library'), site_media_library_path
  end

  def attachment_params
    params.require(:attachment).permit(:file, :page_id, :_destroy)
  end
end
