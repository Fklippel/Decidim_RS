# For tuning the Content Security Policy, check the Decidim documentation site
# https://docs.decidim.org/develop/en/customize/content_security_policy
Rails.application.config.content_security_policy do |policy|
policy.default_src :self, :https
policy.img_src :self, :https, "https://*.hereapi.com",  "https://*.google.com", "https://*.google-analytics.com", :data
end
