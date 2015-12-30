#WSO2-DAS (WSO2 Data Analytics Server) 
The WSO2 Data Analytics Server image. It expects a MySQL server to be running, with the appropriately installed artifacts and database tables for usage with the API Manager.

It is configured to be used with the office MySQL image with port 3306 exposed and the klousiaj/wso2-am image.

The following ports should be published:
- 7714
- 7614
- 9163
- 9446
- 9766
- 21004

Example run:
`docker run -it -p 9163:9163 -p 7714:7714 -p 7614:7614 -p 21004:21004 -p 9446:9446 -p 9766:9766 -d klousiaj/wso2-das:tag`

