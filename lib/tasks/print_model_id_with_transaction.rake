namespace :print_model_id_with_transaction do
  desc 'トランザクション利用時のmodelのidを確認'

  task run: :environment do
    # rake taskだと、`config.active_record.verbose_query_logs = true` であってもSQLログが出ないので、設定しておく
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    Rails.logger.level = Logger::DEBUG

    ActiveRecord::Base.transaction do
      apple = Apple.build(name: 'シナノゴールド')
      puts "step1: plan.id => #{apple.id}"
      apple.save
      puts "step2: plan.id => #{apple.id}"

      raise ActiveRecord::Rollback
    end

    apple_without_transaction = Apple.build(name: '奥州ロマン')
    puts "step3: plan.id => #{apple_without_transaction.id}"
    apple_without_transaction.save
    puts "step4: plan.id => #{apple_without_transaction.id}"
  end
end
