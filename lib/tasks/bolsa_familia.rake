namespace :bolsa_familia do
  desc 'Creates infrastructure for partition tables'
  task infrastructure: :environment do
    BolsaFamilia::Infrastructure.create
  end

  desc 'Downloads the payments file (`rails bolsa_familia:download[2, 2015]`)'
  task :download, [:month, :year] => :environment do |_task, args|
    BolsaFamilia::Download.perform(args.month, args.year)
  end

  desc 'Downloads all the payments file'
  task download_all: :environment do
    (2011..Time.current.year).each do |year|
      (1..12).each do |month|
        break if year == Time.current.year && month == Time.current.month
        Rake::Task['bolsa_familia:download'].invoke(month, year)
      end
    end
  end

  desc 'Imports the payments (`rails bolsa_familia:import[2, 2015]`)'
  task :import, [:month, :year] => :environment do |_task, args|
    BolsaFamilia::Import.perform(args.month, args.year)
  end

  desc 'Imports the all downloaded payments'
  task import_all: :environment do
    (2011..Time.current.year).each do |year|
      (1..12).each do |month|
        break if year == Time.current.year && month == Time.current.month
        Rake::Task['bolsa_familia:import'].invoke(month, year)
      end
    end
  end

  desc 'Downloads and imports the payments (`rails bolsa_familia:download_and_import[2, 2015]`)'
  task :download_and_import, [:month, :year] => :environment do |_task, args|
    Rake::Task['bolsa_familia:download'].invoke(args.month, args.year)
    Rake::Task['bolsa_familia:import'].invoke(args.month, args.year)
  end
end
