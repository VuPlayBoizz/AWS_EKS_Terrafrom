# AWS_EKS_Terrafrom
![Kiến trúc k8s](https://github.com/user-attachments/assets/2047b9d9-bfab-4692-a741-10e9da1c029d)

# 🚀 AWS EKS Terraform Deployment Project

Triển khai hệ thống **Amazon EKS** đa môi trường (Dev/Prod) trên **AWS** bằng **Terraform** kết hợp quy trình tự động hoá **CI/CD Jenkins Pipeline**.

---

## 🏗️ Kiến trúc tổng quan

Dự án này giúp bạn dễ dàng xây dựng và quản lý cơ sở hạ tầng **EKS Cluster** kèm theo:

- VPC Networking (Public/Private Subnets, NAT Gateway)
- Security Groups và IAM Roles
- EKS Control Plane & Managed Worker Nodes
- Bastion Host cho phép SSH vào Worker Nodes
- Triển khai CI/CD pipeline với Jenkins
- Tích hợp GitHub Webhook cho tự động hoá build/deploy

---

## 📂 Cấu trúc thư mục chính

```plaintext
AWS_EKS_Terraform/
├── /Environment/
│   ├── Dev/               # Terraform deploy môi trường DEV tại us-east-1
│   └── Prod/              # Terraform deploy môi trường PROD tại ap-southeast-1
├── /Global/
│   ├── aws_networking/    # Triển khai Networking (VPC, Subnet, Gateway, Route tables)
│   ├── aws_iam/           # Tạo các IAM roles và policies
│   ├── aws_eks/           # Triển khai EKS Cluster & Worker Nodes
│   └── aws_ec2/           # Bastion Host EC2 instance
└── README.md
```

---

## 🌎 Chi tiết thư mục `/Global`
- `provider`
- `terraform version`
### 📁 `/aws_networking`  
Bao gồm các thành phần mạng cơ bản:

- `aws_vpc`
- `aws_subnet`  
  ➡️ 2 Public Subnet và 2 Private Subnet  
- `aws_internet_gateway`
- `aws_nat_gateway`
- `aws_route_tables`  
  ➡️ 1 Public Route Table  
  ➡️ 1 Private Route Table  
- `aws_prefix_list`  
  ➡️ CIDR Block `172.0.0.0/16` và `173.0.0.0/16`  
- `aws_security_groups`  
  - **Control Plane SG:** Cho phép tất cả traffic từ VPC CIDR  
  - **Worker Node SG:** Cho phép tất cả traffic từ Prefix List  
  - **Public SG:** Chỉ IP máy tính cá nhân có quyền truy cập  

### 📁 `/aws_iam`  
IAM Roles & Policies cho:

- `AmazonEKSWorkerNodePolicy`
- `AmazonEC2ContainerRegistryReadOnly`
- `AmazonEKS_CNI_Policy`
- `AmazonEBSCSIDriverPolicy`

### 📁 `/aws_eks`

- `aws_eks_cluster`: Khởi tạo EKS Cluster
- `aws_worker_node`: Tạo 2 Worker Node trong Private Subnet
- `aws_addons`: Cài các thành phần bổ sung (CoreDNS, Metrics Server, EBS Driver, ...)

### 📁 `/aws_ec2`

- `aws_key_pair`: Sinh SSH key để truy cập server
- `aws_ec2`: Tạo 1 Bastion Host trong Public Subnet để kết nối vào Worker Node

---

## 🌐 Các môi trường triển khai

| Environment | Region           |
|-------------|------------------|
| Dev         | `us-east-1`      |
| Prod        | `ap-southeast-1` |

---

## 🛠️ Triển khai Terraform

### 1. Khởi tạo Terraform
```bash
terraform init
```

### 2. Kiểm tra cấu hình
```bash
terraform plan -var-file=dev.tfvars
terraform plan -var-file=prod.tfvars
```

### 3. Triển khai hệ thống
```bash
terraform apply -var-file=dev.tfvars
terraform apply -var-file=prod.tfvars
```

---

## 🏢 CI/CD Pipeline với Jenkins

### 🟢 **Step 1: Cấu hình Jenkins Server và Worker Node**  

### 🟢 **Step 2: Tạo Webhook Github Build Trigger**
- Theo dõi các hành động Pull Request và Push để tự động kích hoạt pipeline.

### 🟢 **Step 3: Tạo Jenkins Credentials**
- Github Credentials  
- AWS Credentials  
- Terraform Credentials  

---

## 📦 Pipeline triển khai Terraform

### 🟢 5.1 Tạo Pipeline với tên `Terraform-plan`

### 🟢 5.2 Cấu hình pipeline


### 🟢 5.3 Tạo Project Parameters  
- `BRANCH_NAME`  
- `REGION`  
- `WORKING_DIRECTORY`  

### 🟢 5.4 Kích hoạt Github Hook Trigger cho GITScm pooling  

### 🟢 5.5 Viết Jenkinsfile cho pipeline `Terraform-plan`
### 🟢 5.6 Viết Jenkinsfile cho pipeline `Terraform-d`

---

## 📝 Ghi chú quan trọng

1. **Bảo mật**  
   - Không commit `terraform.tfstate` hoặc file key.
   - Quản lý state file bằng S3 và DynamoDB để đồng bộ và khoá state.

2. **Chi phí AWS**  
   - Hệ thống tạo ra tài nguyên AWS thật. Đảm bảo bạn kiểm soát tốt chi phí khi chạy lâu dài.

---
