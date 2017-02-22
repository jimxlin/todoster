require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe "tasks#index" do
    it "should list the tasks in the database" do
      task1 = FactoryGirl.create(:task)
      task2 = FactoryGirl.create(:task)
      task1.update_attributes(title: "Something else")
      get :index

      expect(response).to have_http_status :success
      expect(json_resp.count).to eq(2)
      response_ids = json_resp.map { |task| task["id"] }
      expect(response_ids).to eq([task1.id, task2.id])
    end
  end

  describe "tasks#create" do
    it "should allow new tasks to be created" do
      post :create, params: { task: { title: "Fix things" } }

      expect(response).to have_http_status(:success)
      expect(json_resp['title']).to eq("Fix things")
      expect(Task.last.title).to eq("Fix things")
    end
  end

  describe "tasks#update" do
    it "should allow tasks to be marked as done" do
      task = FactoryGirl.create(:task, done: false)
      put :update, params: { id: task.id, task: { done: true } }

      expect(response).to have_http_status(:success)
      task.reload
      expect(task.done).to eq(true)
    end
  end

  describe "tasks#destroy" do
    it "should allow tasks to be deleted" do
      task = FactoryGirl.create(:task, title: 'Foo')
      delete :destroy, params: { id: task.id }

      expect(response).to have_http_status(:success)
      expect(Task.find_by(title: 'Foo')).to be_nil
    end
  end
end
