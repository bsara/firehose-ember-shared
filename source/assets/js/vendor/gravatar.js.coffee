class Gravatar 
  
  @fromEmail: (email) ->
    if email?
      e = email.trim().toLowerCase()
      hashedEmail = md5(e)
    "https://www.gravatar.com/avatar/#{hashedEmail}?d=identicon"
  
window.Gravatar = Gravatar