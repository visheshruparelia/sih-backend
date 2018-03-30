class UserMailer < ApplicationMailer
    def digest_email_update(to_email,file_id,user)
        @user = user
        @to_email = to_email
        @file_id = file_id

        mail(to: @to_email , subject: "Regarding the delay in transfer of the file")

    end
end
