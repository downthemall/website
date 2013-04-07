require 'psych'

module DumpHelpers
  def dump_path(path)
    File.join(File.dirname(__FILE__), "../../dumps", path)
  end

  def dump_file(path)
    File.new(dump_path(path))
  end

  def dump(path)
    dump_file(path).read
  end

  def yaml_dump(path)
    Psych.load(dump(path))
  end

  def write_dump(text, path)
    File.open(dump_path(path), 'w') do |f|
      f.write text
    end
  end

  def write_yaml_dump(obj, path)
    write_dump(Psych.dump(obj), path)
  end
end

RSpec.configure do |c|
  c.include DumpHelpers
end

