
![Capture d’écran 2023-07-07 à 17 04 10](https://github.com/MassiHadjloum/aws_tp/assets/80093922/5908c84f-3676-4d21-8689-b589dfafc35a)

TP réalisé par: 

-BOUHALA yacine

-HADJLOUM massi

------------------------------------------- instataltion du projet-------------------------------------

1- recupérer le dossier dpuis le repot git 
2- changer les clé d'access dans les fichier:
   -provider.tf:
	*. mettre votre:
 
          		  _access_key
	      
	    		  _secret_key

   -iamRoleAndPermissions.tf:
      mettre votre ID de compte après le 'eu-west-3:' au lignes:
	_ 36, 37, 49, 50, 87, 

3- puis se rendre dans le dossier via terminal 

4- lancer les commandes suivante:

   -terraform init
   
   -terraform destroy
   
   -terraform plan
    
   -terraform apply

5- une fois ça de fait vous devriez mettre en place un déclancheur via votre console aws pour cela vous devez vous rendre a:
	aws console > dynamdb > tables > choisir : action table > Exportations et flux > crèer un déclancheur > choisiir writeToContenteDB > cliquer sur créer    	un declancheur  

6- une fois ses étapes faites vous devez:
    *. prendre l'url prode presente dans votre terminal issue de la commande terraform apply
    *. ouvrir votre postman(ou autre)
    *. metre l'url et rajouter /job a la fin 
    *. mettre un body a votre requette exp:
            si vous voulez ajouer un job dans la table contente vous devriez alors faire:
			` {
  			  "id": "1",
    			  "job_type": "nimoorte quoi ",
    			  "is_done": "false",
    			  "contente":"lipute pip"
			} `
mais vous voulez mettre dans un S3 il faut mettre le type a 'S3' (avec un s majiscule)
7_ ce process permetra de mettre le job dans une table appélé job via une lambda appelé writeTojob puis pour chaque nouvelle elément ajouté a cette table une autre lambda ce déclanchera automatiquement pour rajouter le job soit dans la table contentTable ou bien dans S3 selon le type donné dans votre requette initiale 

8- si vous voulez voir tout les jobs contenue dans votre table job(la premiere table qui contient tout les jobs(S3 et autre)) vous devez:
   faire une requette GET sur la route 'url' et rajouter /jobs a la fin 

   shéma:

   ![Uploading shéma.png…]()


    
   
