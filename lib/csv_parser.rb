require 'csv'

class CsvParser
  def initialize(file_path, model_name, converter, limit: 1000)
    @file_path = file_path
    @model = model_name
    @converter = converter
    @limit = limit
  end

  def all
    before_total = @model_name.count
    import!
    after_total = @model_name.count
    inserted = after_total - before_total
    Rails.logger.info "#{inserted} records was inserted."
  end

  private

  def import!
    records = []
    CSV.foreach(@file_path, csv_options).with_index do |row, index|
      break if index > @limit
      records << record_for(row)
      puts_green('.')

      next unless index % 500 == 0
      @model.import(records)
      records = []
    end
  end

  def record_for(row)
    data = @converter.convert(row.to_h)
    @model.new(data).tap do |record|
      record.create_partition_from_record if record.respond_to?(:create_partition_from_record)
    end
  end

  def puts_green(text)
    Rails.logger.info "\e[#{32}m#{text}\e[0m"
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
