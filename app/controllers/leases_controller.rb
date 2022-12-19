class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response 
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_inputs   

def index
    leases = Lease.all
    render json: leases
end

def create
  lease = Lease.create!(lease_params)
  render json: lease, status: :created
end

def destroy
    lease = Lease.find(params[:id])
    lease.destroy
    head :no_content
end

private

def lease_params
    params.permit(:tenant_id, :apartment_id, :rent)
end



def render_not_found_response 
render json: {error:"not found"}, status: :not_found
end

def invalid_inputs(invalid)
    render json: {errors:invalid_record_errors}, status: :unprocessable_entity
end
end
