{ config, pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    google-cloud-sdk
    k9s
    kind
    kubectl
    kubectl-view-secret
    slack
    terraform
    terraform-ls
    beekeeper-studio
  ];

}
