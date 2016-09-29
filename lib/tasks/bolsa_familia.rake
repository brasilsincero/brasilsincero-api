namespace :bolsa_familia do
  desc "Imports the payments of Bolsa Familia (`rails bolsa_familia:importer['201502']`)"
  task :importer, [:date] => :environment do |_task, args|
    filename = "tmp/#{args.date}_BolsaFamiliaFolhaPagamento.csv"
    parser = CsvParser.new(filename, BolsaFamiliaPayment, BolsaFamiliaPaymentConverter)
    parser.all
  end
end
