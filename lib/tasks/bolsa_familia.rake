namespace :bolsa_familia do
  desc "Imports the payments of Bolsa Familia (`rails bolsa_familia:importer['201502']`)"
  task :import, [:date] => :environment do |_task, args|
    filename = "tmp/#{args.date}_BolsaFamiliaFolhaPagamento.csv"
    parser = CsvParser.new(filename, BolsaFamiliaPayment, BolsaFamiliaPaymentConverter)
    parser.all
  end

  desc 'Creates infrastructure for partition tables'
  task infrastructure: :environment do
    BolsaFamilia::Infrastructure.create
  end

  desc 'Downloads the Bolsa Familia payments file (`rails bolsa_familia:download[2, 2015]`)'
  task :download, [:month, :year] => :environment do |_task, args|
    BolsaFamilia::Download.perform(args.month, args.year)
  end
end
