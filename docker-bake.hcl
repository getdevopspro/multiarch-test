// docker-bake.hcl
variable "GITHUB_REPOSITORY_OWNER" {
  default = "getdevopspro"
}

variable "GITHUB_REPOSITORY" {
  default = "getdevopspro/multiarch-test"
}

variable "APP1_IMAGE_NAME" {
  default = "ghcr.io/${lower(GITHUB_REPOSITORY_OWNER)}/app1"
}

variable "APP2_IMAGE_NAME" {
  default = "ghcr.io/${lower(GITHUB_REPOSITORY_OWNER)}/app2"
}

function "generate_tags" {
  params = [image, tags]
  result = formatlist("%s:%s", image, tags)
}

group "build" {
  targets = ["build-app1", "build-app2"]
  platforms = [
    // "linux/amd64",
    "linux/arm64",
  ]
}

target "docker-metadata-action" {}

target "build-base" {
  context    = "./"
  dockerfile = "Dockerfile"
  platforms = [
    "linux/amd64",
    "linux/arm64",
  ]
}

target "build-app1" {
  inherits = ["build-base"]
  target   = "app1"
  tags = concat(
    generate_tags(APP1_IMAGE_NAME, coalesce(target.docker-metadata-action.tags, ["dev"])),
  )
  labels = merge(
    target.docker-metadata-action.labels,
    {
      "org.opencontainers.image.description" = "Multi-architecture application 1",
      "org.opencontainers.image.title"       = "Multi-arch App 1",
    },
  )
  annotations = concat(
    coalesce(target.docker-metadata-action.annotations, []),
    [
      "manifest:org.opencontainers.image.description=Multi-architecture application 1",
      "manifest:org.opencontainers.image.title=Multi-arch App 1",
    ]
  )
}

target "build-app2" {
  inherits = ["build-base"]
  target   = "app2"
  tags = concat(
    generate_tags(APP2_IMAGE_NAME, coalesce(target.docker-metadata-action.tags, ["dev"])),
  )
  labels = merge(
    target.docker-metadata-action.labels,
    {
      "org.opencontainers.image.description" = "Multi-architecture application 2",
      "org.opencontainers.image.title"       = "Multi-arch App 2",
    },
  )
  annotations = concat(
    coalesce(target.docker-metadata-action.annotations, []),
    [
      "manifest:org.opencontainers.image.description=Multi-architecture application 2",
      "manifest:org.opencontainers.image.title=Multi-arch App 2",
    ]
  )
}
