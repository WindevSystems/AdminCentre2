class ApplicationController < ActionController::Base
  rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render :text => exception, :status => 500
  end
    before_action :check_ip_ban

    def check_ip_ban
        if IpBanHelper.ipbanned?(request.remote_ip)
          # Redirect to root path, show an error message, or handle the ban in another way
          render json: { success: false, error: "You have been banned from this service. Reason: #{IpBanHelper.banreason(request.remote_ip)}. This ban will expire on #{IpBanHelper.expirationdate(request.remote_ip)}. You may appeal this ban on #{IpBanHelper.appealabledate(request.remote_ip)}." }
        end
    end

    def apihello
        commit = `git rev-parse --short HEAD`
        cmsg = `git log --format=%B -n 1`

        if ENV['CODESPACES'].nil?
            codespaces = false
        else
            codespaces = true
        end
        render json: { hello: "world", git: { commit: commit.delete("\n"), message: cmsg.delete("\n") }, ac2: "is a dysfunctional Axon ripoff, sorry whitehill", rails: { env: Rails.env.to_s, version: Rails.version.to_s }, codespaces: codespaces.to_s, devs: { Kryptologist: "i do believe im on fire *fucking dies*", Not_Ty: "dont b dum wen work on api or anthin else" }, you: "why are you snooping around here", thanks: "coreui people, copilot" }
    end
end
