resource "aws_ecr_repository" "cms_magazine_batch_ecr" {
  name                 = "${var.project_name}-${var.env}-cms-magazine-batch-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name      = "${var.project_name}-${var.env}-cms-magazine-batch-ecr"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

resource "aws_ecr_lifecycle_policy" "cms_magazine_batch_ecr_policy" {
  repository = aws_ecr_repository.cms_magazine_batch_ecr.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire untagged images"
        selection = {
          tagStatus   = "untagged"
          countType   = "imageCountMoreThan"
          countNumber = 2
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}

resource "aws_ecr_repository" "cms_pleasure_batch_ecr" {
  name                 = "${var.project_name}-${var.env}-cms-pleasure-batch-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name      = "${var.project_name}-${var.env}-cms-pleasure-batch-ecr"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

resource "aws_ecr_lifecycle_policy" "cms_pleasure_batch_ecr_policy" {
  repository = aws_ecr_repository.cms_pleasure_batch_ecr.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire untagged images"
        selection = {
          tagStatus   = "untagged"
          countType   = "imageCountMoreThan"
          countNumber = 2
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}

resource "aws_ecr_repository" "cms_promotion_batch_ecr" {
  name                 = "${var.project_name}-${var.env}-cms-promotion-batch-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name      = "${var.project_name}-${var.env}-cms-promotion-batch-ecr"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

resource "aws_ecr_lifecycle_policy" "cms_promotion_batch_ecr_policy" {
  repository = aws_ecr_repository.cms_promotion_batch_ecr.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire untagged images"
        selection = {
          tagStatus   = "untagged"
          countType   = "imageCountMoreThan"
          countNumber = 2
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}

resource "aws_ecr_repository" "cms_shop_coupon_batch_ecr" {
  name                 = "${var.project_name}-${var.env}-cms-shop-coupon-batch-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name      = "${var.project_name}-${var.env}-cms-shop-coupon-batch-ecr"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

resource "aws_ecr_lifecycle_policy" "cms_shop_coupon_batch_ecr_policy" {
  repository = aws_ecr_repository.cms_shop_coupon_batch_ecr.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire untagged images"
        selection = {
          tagStatus   = "untagged"
          countType   = "imageCountMoreThan"
          countNumber = 2
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}

resource "aws_ecr_repository" "cms_theme_batch_ecr" {
  name                 = "${var.project_name}-${var.env}-cms-theme-batch-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name      = "${var.project_name}-${var.env}-cms-theme-batch-ecr"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

resource "aws_ecr_lifecycle_policy" "cms_theme_batch_ecr_policy" {
  repository = aws_ecr_repository.cms_theme_batch_ecr.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire untagged images"
        selection = {
          tagStatus   = "untagged"
          countType   = "imageCountMoreThan"
          countNumber = 2
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}

resource "aws_ecr_repository" "cms_trailer_package_batch_ecr" {
  name                 = "${var.project_name}-${var.env}-cms-trailer-package-batch-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name      = "${var.project_name}-${var.env}-cms-trailer-package-batch-ecr"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

resource "aws_ecr_lifecycle_policy" "cms_trailer_package_batch_ecr_policy" {
  repository = aws_ecr_repository.cms_trailer_package_batch_ecr.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire untagged images"
        selection = {
          tagStatus   = "untagged"
          countType   = "imageCountMoreThan"
          countNumber = 2
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}

resource "aws_ecr_repository" "hello_movie_detail_batch_ecr" {
  name                 = "${var.project_name}-${var.env}-hello-movie-detail-batch-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name      = "${var.project_name}-${var.env}-cms-trailer-package-ecr"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

resource "aws_ecr_lifecycle_policy" "hello_movie_detail_batch_ecr_policy" {
  repository = aws_ecr_repository.hello_movie_detail_batch_ecr.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire untagged images"
        selection = {
          tagStatus   = "untagged"
          countType   = "imageCountMoreThan"
          countNumber = 2
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}

resource "aws_ecr_repository" "hello_tc_coupon_batch_ecr" {
  name                 = "${var.project_name}-${var.env}-hello-tc-coupon-batch-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name      = "${var.project_name}-${var.env}-hello-tc-coupon-batch-ecr"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

resource "aws_ecr_lifecycle_policy" "hello_tc_coupon_batch_ecr_policy" {
  repository = aws_ecr_repository.hello_tc_coupon_batch_ecr.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire untagged images"
        selection = {
          tagStatus   = "untagged"
          countType   = "imageCountMoreThan"
          countNumber = 2
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}

resource "aws_ecr_repository" "hello_tc_coupon_used_batch_ecr" {
  name                 = "${var.project_name}-${var.env}-hello-tc-coupon-used-batch-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name      = "${var.project_name}-${var.env}-hello-tc-coupon-used-batch-ecr"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

resource "aws_ecr_lifecycle_policy" "hello_tc_coupon_used_batch_ecr_policy" {
  repository = aws_ecr_repository.hello_tc_coupon_used_batch_ecr.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire untagged images"
        selection = {
          tagStatus   = "untagged"
          countType   = "imageCountMoreThan"
          countNumber = 2
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}

resource "aws_ecr_repository" "hello_tc_ticket_batch_ecr" {
  name                 = "${var.project_name}-${var.env}-hello-tc-ticket-batch-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name      = "${var.project_name}-${var.env}-hello-tc-ticket-batch-ecr"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

resource "aws_ecr_lifecycle_policy" "hello_tc_ticket_batch_ecr_policy" {
  repository = aws_ecr_repository.hello_tc_ticket_batch_ecr.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire untagged images"
        selection = {
          tagStatus   = "untagged"
          countType   = "imageCountMoreThan"
          countNumber = 2
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}

resource "aws_ecr_repository" "hello_tc_ticket_used_batch_ecr" {
  name                 = "${var.project_name}-${var.env}-hello-tc-ticket-used-batch-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name      = "${var.project_name}-${var.env}-hello-tc-ticket-used-batch-ecr"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

resource "aws_ecr_lifecycle_policy" "hello_tc_ticket_used_batch_ecr_policy" {
  repository = aws_ecr_repository.hello_tc_ticket_used_batch_ecr.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire untagged images"
        selection = {
          tagStatus   = "untagged"
          countType   = "imageCountMoreThan"
          countNumber = 2
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}

resource "aws_ecr_repository" "hello_theater_schedule_batch_ecr" {
  name                 = "${var.project_name}-${var.env}-hello-theater-schedule-batch-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name      = "${var.project_name}-${var.env}-hello-theater-schedule-batch-ecr"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

resource "aws_ecr_lifecycle_policy" "hello_theater_schedule_batch_ecr_policy" {
  repository = aws_ecr_repository.hello_theater_schedule_batch_ecr.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire untagged images"
        selection = {
          tagStatus   = "untagged"
          countType   = "imageCountMoreThan"
          countNumber = 2
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}

resource "aws_ecr_repository" "purchaseinfo_batch_ecr" {
  name                 = "${var.project_name}-${var.env}-purchaseinfo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name      = "${var.project_name}-${var.env}-purchaseinfo"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

resource "aws_ecr_lifecycle_policy" "purchaseinfo_batch_ecr_policy" {
  repository = aws_ecr_repository.purchaseinfo_batch_ecr.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire untagged images"
        selection = {
          tagStatus   = "untagged"
          countType   = "imageCountMoreThan"
          countNumber = 2
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}

resource "aws_ecr_repository" "tc_coupon_cleaner_batch_ecr" {
  name                 = "${var.project_name}-${var.env}-tc-coupon-cleaner-batch-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name      = "${var.project_name}-${var.env}-tc-coupon-cleaner-batch-ecr"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

resource "aws_ecr_lifecycle_policy" "tc_coupon_cleaner_batch_ecr_policy" {
  repository = aws_ecr_repository.tc_coupon_cleaner_batch_ecr.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire untagged images"
        selection = {
          tagStatus   = "untagged"
          countType   = "imageCountMoreThan"
          countNumber = 2
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}

resource "aws_ecr_repository" "tc_ticket_cleaner_batch_ecr" {
  name                 = "${var.project_name}-${var.env}-tc-ticket-cleaner-batch-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name      = "${var.project_name}-${var.env}-tc-ticket-cleaner-batch-ecr"
    Env       = var.env
    ManagedBy = "Terraform"
  }
}

resource "aws_ecr_lifecycle_policy" "tc_ticket_cleaner_batch_ecr_policy" {
  repository = aws_ecr_repository.tc_ticket_cleaner_batch_ecr.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire untagged images"
        selection = {
          tagStatus   = "untagged"
          countType   = "imageCountMoreThan"
          countNumber = 2
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}
