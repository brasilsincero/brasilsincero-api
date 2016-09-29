require 'csv'

class CsvParser
  def initialize(file_path, model_name, converter)
    @file_path = file_path
    @model = model_name
    @converter = converter
  end

  def all
    total = import!
    puts "#{total} records was imported."
  end

  private

  def import!
    total = 0
    records = []
    CSV.foreach(@file_path, csv_options).with_index do |row, index|
      records << record_for(row)
      increment(total)

      next unless index % 500 == 0
      @model.import(records)
      records = []
    end
    total
  end

  def record_for(row)
    data = @converter.convert(row.to_h)
    @model.new(data).tap do |record|
      record.create_partition_from_record if record.respond_to?(:create_partition_from_record)
    end
  end

  def increment(total)
    total += 1
    puts_green('.')
  end

  def puts_green(text)
    print "\e[#{32}m#{text}\e[0m"
  end

  def csv_options
    {
      headers: true,
      col_sep: "\t",
      encoding: 'ISO8859-1',
      header_converters: ->(header) { header.parameterize(separator: '_').tr('-', '_') }
    }
  end
end
