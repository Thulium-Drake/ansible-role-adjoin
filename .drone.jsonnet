local Lint() = {
  name: "Lint",
  kind: "pipeline",
  steps: [
    {
      name: "Lint code",
      image: "quay.io/ansible/molecule",
      commands: [
        "molecule lint",
        "molecule syntax"
      ]
    }
  ]
};

local Converge(distro) = {
  kind: "pipeline",
  name: "Test - "+distro,
  steps: [
    {
      name: "Converge and verify",
      image: "quay.io/ansible/molecule",
      commands: [
        "molecule cleanup",
        "molecule destroy",
        "molecule create",
        "molecule converge",
        "molecule idempotence",
        "molecule verify",
        "molecule cleanup",
      ],
      privileged: true,
      volumes: [
        { name: "docker", path: "/var/run/docker.sock" },
      ],
    }
  ],
  volumes: [
    { name: "docker",
      host: { path: "/var/run/docker.sock" } },
  ],
};

[
  Lint(),
  Converge("debian9"),
  Converge("debian8"),
  Converge("centos7"),
  Converge("centos6"),
  Converge("ubuntu1804"),
  Converge("ubuntu1604"),
]
