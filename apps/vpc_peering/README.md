

<h1> Requester block workaround. </h1>
Terraform is unable to modify the requester perring connection before it is accepted.  This leaves an unhandled race condidtion where Terraform is unable to complete creating the vpc_peering_connection resource.  Removeing the requester block resolves this but leaves the connection without proper DNS.  To resolve this we do not add the dns setting in Terraform but by running the following cli post sucessful run.

*NOTE* ensure that you setup your credentials and profile before attempting to run code.

aws ec2 modify-vpc-peering-connection-options --vpc-peering-connection-id <pcx-aaaabbbb> --requester-peering-connection-options AllowDnsResolutionFromRemoteVpc=true