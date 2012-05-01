class Setting < Settingslogic
  source "#{Rails.root}/config/settings.yml"
  namespace Rails.env
end
