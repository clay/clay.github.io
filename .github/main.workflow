workflow "Deploy to GitHub Pages" {
  on = "push"
  resolves = ["Build and push docs"]
}

action "Filter branch" {
  uses = "actions/bin/filter@master"
  args = "branch develop"
}

action "Install" {
  needs = ["Filter branch"]
  uses = "actions/npm@master"
  args = "install --prefix ./website"
}

action "Build and push docs" {
  needs = ["Install"]
  uses = "clay/docusaurus-github-action@master"
  args = "deploy"
  env = {
    PROJECT_NAME = "clay"
  }
  secrets = ["DEPLOY_SSH_KEY"]
}
