class CreateBolsaFamiliaPayments < ActiveRecord::Migration[5.0]
  def up
    create_table :bolsa_familia_payments do |t|
      t.string :uf
      t.string :codigo_siafi_municipio
      t.string :nome_municipio
      t.string :codigo_funcao
      t.string :codigo_subfuncao
      t.string :codigo_programa
      t.string :codigo_acao
      t.string :nis_favorecido
      t.string :nome_favorecido
      t.string :fonte_finalidade
      t.decimal :valor_parcela
      t.date :data_competencia

      t.timestamps
    end
  end

  def down
    drop_table :bolsa_familia_payments, force: :cascade
  end
end
