class UploadedFile
  def initialize(hash)
    @hash = hash
  end

  def tempfile
    @hash[:tempfile]
  end

  def original_filename
    @hash[:filename]
  end

  def content_type
    @hash[:type]
  end

  def path
    tempfile.path
  end
end
