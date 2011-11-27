Backup::Model.new(:sixlinks, 'Fluidtask Backup') do

  database MySQL do |db|
    db.name               = "fluidtask"
    db.username           = "root"
    db.password		  = ""
    db.host               = "localhost"
    db.port               = 3306
    db.socket             = "/tmp/mysql.sock"
   end

  store_with S3 do |s3|
    s3.access_key_id      = 'AKIAJTNZWCZDOIDWFR4A'
    s3.secret_access_key  = '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'
    s3.region             = 'us-east-1'
    s3.bucket             = 'qi-backups'
    s3.path               = '/fluidtask'
    s3.keep               = 3
  end

  compress_with Gzip do |compression|
    compression.best = true
    compression.fast = false
  end

end

Backup::Model.new(:sixlinks, 'Sixlinks Backup') do

  database MySQL do |db|
    db.name               = "sixlinks"
    db.username           = "root"
    db.password		  = ""
    db.host               = "localhost"
    db.port               = 3306
    db.socket             = "/tmp/mysql.sock"
   end

  store_with S3 do |s3|
    s3.access_key_id      = 'AKIAJTNZWCZDOIDWFR4A'
    s3.secret_access_key  = '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'
    s3.region             = 'us-east-1'
    s3.bucket             = 'qi-backups'
    s3.path               = '/sixlinks'
    s3.keep               = 3
  end

  compress_with Gzip do |compression|
    compression.best = true
    compression.fast = false
  end

end

