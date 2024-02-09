resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_kms_key" "kms" {
  description = "${var.project_name} - MSK Cluster"
}

resource "aws_msk_cluster" "cluster" {
  cluster_name           = var.project_name
  kafka_version          = var.msk_version
  number_of_broker_nodes = var.msk_brokers_pr_nodes * 3

  broker_node_group_info {
    instance_type = var.msk_instance_type

    client_subnets = [
      aws_subnet.subnet_az1.id,
      aws_subnet.subnet_az2.id,
      aws_subnet.subnet_az3.id,
    ]
    security_groups = [aws_security_group.sg.id]

    connectivity_info {
      public_access {
        type = var.msk_public_access
      }
    }

    storage_info {
      ebs_storage_info {
        volume_size = var.msk_volume_size
      }
    }
  }

  encryption_info {
    encryption_at_rest_kms_key_arn = aws_kms_key.kms.arn
  }

  open_monitoring {
    prometheus {
      jmx_exporter {
        enabled_in_broker = true
      }
      node_exporter {
        enabled_in_broker = true
      }
    }
  }

  client_authentication {
    sasl {
      iam = true
    }
  }
}

output "zookeeper_connect_string" {
  value = aws_msk_cluster.cluster.zookeeper_connect_string
}

output "bootstrap_brokers_tls" {
  description = "TLS connection host:port pairs"
  value       = aws_msk_cluster.cluster.bootstrap_brokers_tls
}
