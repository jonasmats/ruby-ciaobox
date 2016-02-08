class Admin::BackupDbsController < Admin::BaseAdminController
  require 'open3'

  add_crumb(I18n.t('admins.breadcrumbs.backup_db')) { |instance| instance.send :admin_backup_dbs_path }

  def index
    @backup_db = {}
    @backup_db[:id] = 0
    @backup_db[:executable] = 0
    @backup_db[:output] = ""
  end

  def update
    @backup_db = {}
    @backup_db[:id] = 0
    @backup_db[:executable] = 1
    @backup_db[:output] = ""

    cmd = "ls -l"
    Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
      @backup_db[:output] = @backup_db[:output] + "\n" + stdout.read
    end

    logger.debug "BACKUPDB:: #{@backup_db.inspect}"

    respond_to do |format|
      format.html { redirect_to admin_backup_dbs_path, notice: "Backup process done!"}
      format.js
    end

  end

  def create
    @backup_db = {}
    @backup_db[:id] = 0
    @backup_db[:executable] = 1
    @backup_db[:output] = ""

    if params[:executable].present? && params[:executable] == '1'
      #cmd = "su - ubuntu -c 'backup perform -t db_backup'"
      cmd = "backup perform -t db_backup"
      #cmd = "sudo -u ubuntu backup perform -t db_backup"
      #cmd = "backup dependencies --install dropbox-sdk"
      Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
        #@backup_db[:output] = @backup_db[:output] + "\n" + stdout.read
        strin = stdout.read + " Error => " + stderr.read
        render json: {code: 100, data: strin}
      end
    end

  end
end