Release "pxc-db" has been upgraded. Happy Helming!
NAME: pxc-db
LAST DEPLOYED: Tue Jul 11 10:53:05 2023
NAMESPACE: pxc-mysql
STATUS: deployed
REVISION: 10
TEST SUITE: None
NOTES:
1. To get a MySQL prompt inside your new cluster you can run:

    ROOT_PASSWORD=`kubectl -n pxc-mysql get secrets prod -o jsonpath="{.data.root}" | base64 --decode`
    kubectl -n pxc-mysql exec -ti \
      prod-pxc-0 -c pxc -- mysql -uroot -p"$ROOT_PASSWORD"

2. To connect an Application running in the same Kubernetes cluster you can connect with:

    ROOT_PASSWORD=`kubectl -n pxc-mysql get secrets prod -o jsonpath="{.data.root}" | base64 --decode`

    kubectl run -i --tty --rm percona-client --image=percona --restart=Never \
  -- mysql -h prod-haproxy.pxc-mysql.svc.cluster.local -uroot -p"$ROOT_PASSWORD"
