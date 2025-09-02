# VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = { Name = "fase1-vpc" }
}

# Sub-rede pública
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidr
  map_public_ip_on_launch = true
  tags = { Name = "fase1-public-subnet" }
}

# Internet Gateway + rotas
resource "aws_internet_gateway" "igw" { vpc_id = aws_vpc.main.id }

resource "aws_route_table" "public" { vpc_id = aws_vpc.main.id }

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Security Group (SSH 22, app 3000)
resource "aws_security_group" "app_sg" {
  name        = "fase1-app-sg"
  description = "Allow SSH and app port"
  vpc_id      = aws_vpc.main.id

  ingress { from_port = 22   to_port = 22   protocol = "tcp" cidr_blocks = ["0.0.0.0/0"] }
  ingress { from_port = 3000 to_port = 3000 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"] }

  egress  { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["0.0.0.0/0"] }
}

# Par de chaves (ajuste a chave pública se necessário)
resource "aws_key_pair" "main" {
  key_name   = var.key_name
  public_key = "ssh-rsa AAA...COLOQUE_SUA_CHAVE_PUBLICA_AQUI..."
}

# AMI Amazon Linux 2
data "aws_ami" "al2" {
  most_recent = true
  owners      = ["137112412989"] # Amazon
  filter { name = "name" values = ["amzn2-ami-hvm-*-x86_64-gp2"] }
}

# Instância EC2 mínima
resource "aws_instance" "app" {
  ami                    = data.aws_ami.al2.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  key_name               = aws_key_pair.main.key_name
  tags = { Name = "fase1-app-ec2" }
}

# S3 para artefatos
resource "random_id" "suffix" { byte_length = 4 }

resource "aws_s3_bucket" "artifacts" {
  bucket = "fase1-artifacts-${random_id.suffix.hex}"
  tags   = { Name = "fase1-artifacts" }
}
