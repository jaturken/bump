require 'pushmeup'

GCM.host = 'https://android.googleapis.com/gcm/send'
# https://android.googleapis.com/gcm/send is default

GCM.format = :json
# :json is default and only available at the moment

GCM.key = "AIzaSyCg-U8doNpny9_Uz89kqxqP-eRGzfa3nm0"
# this is the apiKey obtained from here https://code.google.com/apis/console/
