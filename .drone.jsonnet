[
  {
    name: "Lint",
    kind: "pipeline",
    steps: [
      {
        name: "Lint code",
        image: "registry.element-networks.nl/tools/molecule",
        commands: [
          "molecule --version",
          "molecule lint",
          "molecule syntax"
        ],
        volumes: [
          { name: "docker", path: "/var/run/docker.sock" },
        ],
      }
    ],
    volumes: [
      { name: "docker",
        host: { path: "/var/run/docker.sock" }
      },
    ],
  },
  {
    name: "Publish",
    kind: "pipeline",
    clone:
      { disable: true },
    steps: [
      {
        name: "Ansible Galaxy",
        image: "registry.element-networks.nl/tools/molecule",
        commands: [
          "ansible-galaxy import --token $$GALAXY_TOKEN Thulium-Drake ansible-role-adjoin --role-name=adjoin",
        ],
        environment:
          { GALAXY_TOKEN: { from_secret: "galaxy_token" } },
      },
    ],
    depends_on: [
      "Lint",
    ],
  },
]
