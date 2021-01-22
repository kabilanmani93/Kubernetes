kubectl run -it --v=0 --rm --restart=Never --overrides='
{
  "spec": {
    "containers": [
      {
        "name": "mysql-client",
        "image": "mysql:5.7",
        "tty": true,
        "stdin": true,
        "command": ["mysql"],
        "args": ["-h", "$(DB_HOSTNAME)", "-u", "$(DB_USERNAME)", "-p$(DB_PASSWORD)"],
        "env": [
          {
            "name": "DB_HOSTNAME",
            "valueFrom": {
              "secretKeyRef": {
                "name": "db-secret",
                "key": "DB_HOSTNAME"
              }
            }
          },
          {
            "name": "DB_USERNAME",
            "valueFrom": {
              "secretKeyRef": {
                "name": "db-secret",
                "key": "DB_USERNAME"
              }
            }
          },
          {
            "name": "DB_PASSWORD",
            "valueFrom": {
              "secretKeyRef": {
                "name": "db-secret",
                "key": "DB_PASSWORD"
              }
            }
          }
        ]
      }
    ]
  }
}
'  --image=mysql:8.0 mysql