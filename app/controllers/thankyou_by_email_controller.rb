class ThankyouByEmailController < ThankyousController
  require 'mail'
  skip_before_filter :verify_authenticity_token

  def input
    message = Mail.new params[:message]
    logger.fatal "message:\t#{message}"

    from = message.from[0]
    logger.fatal "from:\t#{from}"
        from_user = User.find_or_create_by_email(from) # TODO: grab name from email

    logger.fatal "from_user:\t#{from_user}"

    message.to.each{|address|
      logger.fatal "address:\t#{address}"
      to_user = User.find_or_create_by_email(address) # TODO: grab name
      logger.fatal "to_user:\t#{to_user}"
      ty = Thankyou.create!(:thanker => from_user.id, :welcomer => to_user.id, :headline => message.subject, :content => message.body)
    logger.fatal "from:\t#{from}"
    logger.fatal "ty:\t#{ty}"
        }
#    from      = message.from[0]
#    to        = message.to[0]
#    from_user = User.find_or_create_by_email(from)
#    to_user   = User.find_or_create_by_email(to)
#    content   = message.body
#    headline  = message.subject
#    from_user.thankyou.create!(:thanker => from_user.id,
#                                  :welcomer => to_user.id,
#                                  :content => content,
#                                  :headline => headline)
    render :text => 'success', :status => 200 # 404 would reject the mail
  end
#                          :password =>             "password",
#                          :password_confirmation => "password")
#     to_user   = User.find_or_create_by_email(to,
#                          :password => "password",
#                          :password_confirmation => "password")
#    message.to.each{|address|
#logger.fatal "address:\t#{address}"
#      to_user = User.find_or_create_by_email(address) # TODO: grab name
#logger.fatal "to_user:\t#{to_user}"
##      from_user = User.find_or_create_by_email(message.from[0])
#      ty = Thankyou.new(:thanker => from, :welcomer => to, :headline => message.subject, :content => message.body)
#logger.fatal "from:\t#{from}"
#logger.fatal "ty:\t#{ty}"
#    ty.save

#    }
#    message.Thankyou.create!(:thanker_id => from_user.id,
#                                 :welcomer_id => to_user.id,
#                                 :headline => message.subject,
#                                 :content => message.body)}

#    message.to.each { |to_user|
#      to_user.thankyou.create!(:thanker => from_user.id,
#                          :welcomer => to_user.id,
#                          :headline => message.subject,
#                          :content => message.body)}

#  end
end

