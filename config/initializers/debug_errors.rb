Rails.application.config.to_prepare do
  if defined?(Decidim::System::OrganizationsController)
    Decidim::System::OrganizationsController.class_eval do
      # Adiciona um filtro que roda logo após a ação de update terminar
      after_action :debug_organization_errors, only: [:update]

      private

      def debug_organization_errors
        # Procuramos pela variável de instância que o Decidim usa no form
        form_object = instance_variable_get(:@form)
        organization = instance_variable_get(:@organization)

        Rails.logger.error "================================================"
        Rails.logger.error "=== [DEBUG] INTERCEPTANDO FORMULÁRIO UPDATE ==="
        
        if form_object && !form_object.valid?
          Rails.logger.error "❌ Erro no FORM OBJECT: #{form_object.errors.full_messages.to_sentence}"
        end

        if organization && !organization.valid?
          Rails.logger.error "❌ Erro no MODEL (Organização): #{organization.errors.full_messages.to_sentence}"
        end

        Rails.logger.error "================================================"
      end
    end
  end
end
