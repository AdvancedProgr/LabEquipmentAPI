class MaintenanceRecordsController < ApplicationController
  before_action :set_maintenance_record, only: [ :show, :update, :destroy ]

  def index
    maintenance_records = MaintenanceRecord.includes(:equipment)

    if params[:equipment_id].present?
      maintenance_records = maintenance_records.where(
        equipment_id: params[:equipment_id]
      )
    end

    maintenance_records = maintenance_records.order(
      performed_at: :desc
    )

    render json: maintenance_records.as_json(
      include: {
        equipment: {
          only: [ :id, :name ]
        }
      }
    ), status: :ok
  end

  def show
    render json: @maintenance_record.as_json(
      include: {
        equipment: {
          only: [ :id, :name ]
        }
      }
    ), status: :ok
  end

  def create
    maintenance_record = MaintenanceRecord.new(
      maintenance_record_params
    )

    if maintenance_record.save
      render json: maintenance_record,
             status: :created
    else
      render json: {
        errors: maintenance_record.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def update
    if @maintenance_record.update(
      maintenance_record_params
    )
      render json: @maintenance_record,
             status: :ok
    else
      render json: {
        errors: @maintenance_record.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def destroy
    @maintenance_record.destroy

    head :no_content
  end

  private

  def set_maintenance_record
    @maintenance_record = MaintenanceRecord.find_by(
      id: params[:id]
    )

    unless @maintenance_record
      render json: {
        error: "Maintenance record not found"
      }, status: :not_found and return
    end
  end

  def maintenance_record_params
    params.require(:maintenance_record).permit(
      :description,
      :performed_at,
      :equipment_id
    )
  end
end
