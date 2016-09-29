require 'csv'

class CsvParser
  def initialize(file_path, model_name, converter)
    @file_path = file_path
    @model = model_name
    @converter = converter
  end

  def all
    records = []
    CSV.foreach(@file_path, csv_options).with_index do |row, index|
      data = @converter.convert(row.to_h)
      record = @model.new(data)
      record.create_partition_from_record if record.respond_to?(:create_partition_from_record)
      records << record

      next unless index % 500 == 0
      @model.import(records)
      records = []
    end
  end

  private

  def csv_options
    {
      headers: true,
      col_sep: "\t",
      encoding: 'ISO8859-1',
      header_converters: ->(header) { header.parameterize(separator: '_').tr('-', '_') }
    }
  end
end
