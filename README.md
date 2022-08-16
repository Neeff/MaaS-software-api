# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
	- 2.7.6
 

* System dependencies
	- PostgreSQL  >= (12.11)
	- Ruby version 2.7.6

* Configuration
	- ``` git clone git@github.com:Neeff/MaaS-software-api.git ```
	- ``` cd MaaS-software-api ```
	- ``` run : bundle install ```
* Database creation
	- ``` run: rails db:create ```
	- ``` run: rails db:migrate ```
* Database initialization
	- ``` run: rails db:seed ```

* How to run the test suite
	- ``` run: bundle exec rspec```

* Description
	- Esta API al ser inicializada desde el seed generará x instancias del modelo AvailableHour donde x será el rango de horas por día establecido por el contrato asociado al servicio.
	- La inicialización generará una especie de plantilla partiendo desde la fecha actual hasta 5 semanas en el futuro, donde cada servicio tendrá x cantidad de horas disponibles.
	- Basándonos en lo anterior todo gira en torno al modelo AvailableHour, y el Modelo intermedio EngineerAvailableHours, en particular este último quien provee de la lógica activar o desactivar las horas que cada Ingeniero tiene disponible, con base en esta información se extraen datos que son utilizados por el módulo Availability::Shift quien hace uso de una gema llamada or_tools, esta recibe dos diccionarios el primero con las horas disponibles por ingeniero, y el segundo las horas o turnos que deben de ser asignados, con esta información la gema hace uso de programación basada en restricciones para obtener la asignación de turnos.
	- Cabe mencionar que el método initializer de la clase BasicScheduler fue sobreescrita, para permitir asignar más de una hora por día a los ingenieros y así optimizar la toma de turnos.

	- Modelos Se puede encontrar una captura del modelo en el repo bajo el nombre de erd.pdf

	- Controladores
		- la aplicación cuenta con tres controladores
			- available_hours_controller: este controlador se encarga de proveer información a la vista mediante dos métodos, index y update, siendo este último quien al recibir una petición con parámetros válidos quien gatillara el recálculo de las asignaciones de turnos.
			- services_controller provee información referente a los servicios.
			- shifs_controller: provee información de los turnos asignados.

	- Servicios
		- Hour: Servicio utilizado principalmente como intermediario para traer información haciendo uso de métodos que encapsulan lógica de negocio perteneciente al modelo.
		- Shift: Servicio que agrupa la lógica para generar los turnos y hacer las asociaciones entre los modelos Shift, AvailableHour, Engineer.
		- Template: Servicio que agrupa la funcionalidad de generación de horas disponibles en un rango x de tiempo.

	- Rake Task:
		- se cuenta con un rake task, que será ejecutado cada semana a una hora específica mediante cron jobs, esto para ir generando las horas disponibles correspondiente a la semana siguiente de la última hora disponible (basado en el attr date de este modelo).
