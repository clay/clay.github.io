workflow "Deploy to GitHub Pages" {
  on = "push"
  resolves = ["Build and push docs"]
}

action "Filter branch" {
  uses = "actions/bin/filter@master"
  args = "branch develop"
}

action "Build and push docs" {
  needs = ["Filter branch"]
  uses = "clay/docusaurus-github-action@master"
  args = "deploy"
  env = {
    PROJECT_NAME = "clay"
  }
  secrets = ["DEPLOY_SSH_KEY", "ALGOLIA_API_KEY"]
}
