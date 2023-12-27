resource "googleworkspace_group_member" "member" {
  group_id = googleworkspace_group.google_workspace_demo.id
  email = "admin@arvil.co"
  role = "MEMBER"
}
