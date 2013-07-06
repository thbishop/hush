HUSH_ENCRYPTION_KEY = String(ENV['HUSH_ENCRYPTION_KEY'])

if HUSH_ENCRYPTION_KEY.blank?
  raise 'You must set environment variable HUSH_ENCRYPTION_KEY'
end
