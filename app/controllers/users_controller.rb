# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :operand_exist?, only: %i[archive unarchive]
  def index
    render jsonapi: User.where(archived: false)
  end

  def archive
    if operand_archived?
      render json: { error: 'This user is already archived!' }, status: :unprocessable_entity
    else
      operand.toggle!(:archived)
      log_operation(:archived)
    end
  end

  def unarchive
    if operand_archived?
      operand.toggle!(:archived)
      log_operation(:unarchived)
    else
      render json: { error: 'This user is already unarchived!' }, status: :unprocessable_entity
    end
  end

  private

  def operand_archived?
    operand.archived
  end

  def operand
    user = User.find_by(id: params[:id])
  end

  def log_operation(operation)
    log = ArchiveLog.new(operator: current_user.id, operand: operand.id, operation: operation)
    if log.save
      render json: log, status: :ok
    else
      render json: { error: 'Operation successed but with errors' }, status: :unprocessable_entity
    end
  end

  def operand_exist?
    render json: { error: 'This user does not exist' }, status: :not_found if operand.nil?
  end
end
