desc 'send digest email'
task send_digest_email: :environment do
  # ... set options if any
  # UserMailer.digest_email_update("venkatraghavan2013@gmail.com" ).deliver_now

  @history = History.where(status_from: 0, status_to: 1)
  for i in @history
      @time = Time.now - i.change_time
      if(@time/86400 >= 3 and @time/86400 < 4)
          @user = User.find(i.changed_by_id)

          UserMailer.digest_email_update("venkatraghavan2013@gmail.com" , i.file_id, @user).deliver_now
      end
  end
end
