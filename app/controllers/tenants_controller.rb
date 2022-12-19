class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response 
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_inputs   
    def index
        tenants = Tenant.all
        render json: tenants
    end

    def show
        tenant = find_tenant
        render json: tenant
    end

    def update
        tenant = find_tenant
        tenant.update(tenant_params)
        render json: tenant
    end

    def create
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :created 
    end

    def destroy 
        tenant = find_tenant
        tenant.destroy
        head :no_content 
    end

    private 
    def tenant_params
        params.permit(:name, :age)
    end

    def find_tenant
        tenant = Tenant.find(params[:id])
    end

    def render_not_found_response 
    render json: {error:"not found"}, status: :not_found
    end

    def invalid_inputs(invalid)
        render json: {errors:invalid_record_errors}, status: :unprocessable_entity
    end
end
