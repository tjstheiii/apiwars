.. apiwars documentation master file, created by
   sphinx-quickstart on Mon Sep  7 21:13:29 2015.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

Welcome to apiwars's documentation!
===================================

Contents:
 
.. toctree::
   :maxdepth: 2
   
   intro
   entities

   
Intro
-----
Welcome to apiwars.  This 'game' is intended to be a mix between popular mmorpgs and the
infamous ProgressQuest, targetted specifically at today's recreational coder.  So, challenge
yourself, challenge a friend, clone our client-starter-repo, create an account, and get to war!

Entities
--------
This section will introduct you to the basic 'things' in the game today.

Accounts
++++++++
You should probably just have one::
  { 'accounts':
      id:
	  email:
      password:
	  verified:
	  verification:
  }

Create by::
  POST /accounts
  { 'accounts':
	  email: <your_email>
  }
  >>
  { 'accounts':
	  id: <your_id>
	  email: <your_email>
	  password: <your_password>
	  verified: false
  }

A verification code will be sent to <your_email>.  Verify your reception with::
  PUT /accounts/<your_id>
  { 'accounts':
      email: <your_email>
	  password: <your_password>
	  verified: true
	  verification: <the_code_you_got_in_email>
  }
  >>
  { 'accounts':
	  id: <your_id>
	  verified: true
  }

Congrats, you know have a verified account and can compete in apiwars.  
  
Characters
++++++++++S

Parties
+++++++

Currencies
++++++++++

Items
+++++

Equipments
++++++++++

Zones
+++++

Enemies
+++++++

Explorations
++++++++++++

Fights
++++++




Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`

