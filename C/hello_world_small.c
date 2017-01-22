#include "sys/alt_stdio.h"
#include "altera_avalon_pio_regs.h"
//#include <stdio.h>
#include <time.h>

#define addr (volatile char *) 0x9110
#define data_in (volatile char *) 0x9120
#define read_write (volatile char *) 0x9100
#define data_out (volatile char *) 0x90f0
#define transmit_enable (volatile char *) 0x90e0
#define char_sent (volatile char *) 0x90d0
#define char_received (volatile char *) 0x90c0
#define p_data_in (volatile char *) 0x90b0   //output
#define p_data_out (volatile char *) 0x90a0  //input
#define load (volatile char *) 0x9090
#define LEDR (volatile char *) 0x9080
#define userin (volatile char *) 0x9070
#define enable1 (volatile char *) 0x9060
#define currentehp (volatile char *) 0x9050
#define currentmp (volatile char *) 0x9040
#define currenthp (volatile char *) 0x9030
#define life (volatile char *) 0x9020
#define enable2 (volatile char *) 0x9010
#define getattack (volatile char *) 0x9000


#define SEND_BAUD_WIDTH 100
#define RECEIVE_BAUD_WIDTH 100

#define START_GAME 0

// global variable
int busyAddr; // memory busy boundary


typedef struct {
	char* name;
	int currentMon;
	int mon[3];
	int tg;
	int mg;
} player;
// function prototype
int keyDecoder(int);
void write(char);
char read(void);
void memAlloc(player); // allocate memory

int getAddress(int, int, char, int);
char getValue(char);
void setValue(char, char);

player initPlayer(player, int, int, int);
char pokemonSkill(int, int, int);
char items(int, int);
char pokemonProp (int, int);
int hpmp (int);

char singlePokeDecoder(int);

#define PLAYER_1 0
#define PLAYER_2 1


// Bus Requirement
// round bus (current round)
// currentPokemon (pull out the pokemon's picture to the screen)
// currentHP (refresh the current HP)
// currentMP (refresh the current MP)

// Memory Instruction
// "damage" located at an address of currentMon * 20 + skillKey * 4 + 1
// "cost" located at an address of currentMon * 20 + skillKey * 4 + 2
// "accuracy" located at an address of currentMon * 20 + skillKey * 4 + 3
// pokemon "No." located at an address of currentMon * 20 + 16
// pokemon's "hp" located at an address of currentMon * 20 + 17
// pokemon's "mp" located at an address of currentMon * 20 + 18

// Notation Brief:
// damage -- d
// cost -- c
// accuracy -- a
// pokemon's No. -- n
// pokemon's hp -- h
// pokemon's mp -- m
// tango's heal -- t
// tango's amount -- l
// mango's heal -- g
// mango's amount -- k
int main()
{ 
	  volatile int round; // 0 for attack, 1 for incoming
	  volatile char currentHP, currentMP, currentPokemon, maxHP, maxMP;
	  volatile char currentEHP, currentEnemy, enemyMaxHP;



	  volatile char dmg, cst, tangoA, mangoA; // damage, heal, cost
	  volatile char healH, healM;
	  volatile char inDmg, eHeal; // enemy's damadge, heal
	  volatile int flag;
	  // initialize pokemon database
	  //init();
	  //usleep(5000000);
	  round = START_GAME;
	  volatile player JunJun;
	  volatile player JunE;
	  JunJun.name = "JUNJUN";

	  JunJun = initPlayer(JunJun, 0, 1, 2);


	  volatile int key = 0;
	  flag = 0;


	  JunE.name = "JUNE";
	  JunE = initPlayer(JunE, 3, 4, 5);

	  //alt_printf("%x, %x, %x, %x, %x, %x\n", JunJun.mon[0], JunJun.mon[1], JunJun.mon[2], JunE.mon[0], JunE.mon[1], JunE.mon[2]);
	  //setValue(busyAddr + 60, 1);
	  volatile int i;
	  // change
	  usleep(1000);

	  maxHP = getValue(getAddress(JunJun.currentMon, 0, 'h', PLAYER_1));
	  maxMP = getValue(getAddress(JunJun.currentMon, 0, 'm', PLAYER_1));
	  enemyMaxHP = getValue(getAddress(JunE.currentMon, 0, 'h', PLAYER_2));
	  int endgame = 0;
	  round = 0; // set the round to attack
	  while(endgame == 0) {

		  // reset variables
		  key = 0;
		  cst = 0;
		  dmg = 0;
		  healH = 0;
		  healM = 0;

		  for(i = 0; i < 120; i++) {
			  alt_printf("%x  ", getValue(i));
		  }
		  alt_printf("\n");
		  // update current state
		  currentHP = getValue(getAddress(JunJun.currentMon, 0, 'h', PLAYER_1));
		  currentMP = getValue(getAddress(JunJun.currentMon, 0, 'm', PLAYER_1));
		  currentEHP = getValue(getAddress(JunE.currentMon, 0, 'h', PLAYER_2));

		  // output current state to screen
		  *currenthp = currentHP;
		  *currentmp = currentMP;
		  *currentehp = currentEHP;
		  *life = 0b111 >> JunJun.currentMon;
		  *enable1 = singlePokeDecoder(JunJun.mon[JunJun.currentMon]);
		  *enable2 = singlePokeDecoder(JunE.mon[JunE.currentMon]);
		  usleep(100);
		  alt_printf("myHP = %x\n", currentHP);
		  alt_printf("myMP = %x\n", currentMP);
		  alt_printf("enemyHP = %x\n", currentEHP);
		  if(0 == round) { // attack
			  while(0 == key) {
				  key |= *userin;
				  key = keyDecoder(key);
			  }
			  if(key > 0 && key <= 4) { // use skills
				  healH = 0;
				  healM = 0;
				  cst = getValue(getAddress(JunJun.currentMon, key, 'c', PLAYER_1));
				  if(cst <= currentMP) { // have enough mana
					  dmg = getValue(getAddress(JunJun.currentMon, key, 'd', PLAYER_1));
					  currentMP -= cst;
					  setValue(getAddress(JunJun.currentMon, 0, 'm', PLAYER_1), currentMP); // Update mp
				  } else { // don't have enough mana
					  dmg = 0;
					  healH = 0;
					  healM = 0;
				  }
			  } else if(5 == key) { // use tango
				  dmg = 0;
				  healM = 0;
				  tangoA = getValue(getAddress(JunJun.currentMon, 0, 'l', PLAYER_1)); // get tango's amount
				  if(tangoA > 0) { // have enough tango
					  setValue(getAddress(JunJun.currentMon, 0, 'l', PLAYER_1), tangoA - 1); // decrement tango's amount
					  usleep(1000);
					  healH = getValue(getAddress(JunJun.currentMon, 0, 't', PLAYER_1)); // get tango's heal
					  //currentHP += healH; // heal

				  } else {
					  alt_printf("Don't have enough tango\n");
					  healH = 0;
					  healM = 0;
					  dmg = 0;
				  }
			  } else if(6 == key) { // use mango
				  dmg = 0;
				  healH = 0;
				  mangoA = getValue(getAddress(JunJun.currentMon, 0, 'k', PLAYER_1)); // get mango's amount
				  usleep(500);
				  if(mangoA > 0) { // have enough mango
					  healM = getValue(getAddress(JunJun.currentMon, 0, 'g', PLAYER_1)); // get mango's heal
					  setValue(getAddress(JunJun.currentMon, 0, 'k', PLAYER_1), mangoA - 1); // decrement mango's amount
					  usleep(10000);
					  //currentMP += healM; // heal

				  } else {
					  alt_printf("Don't have enough mango\n");
					  healH = 0;
					  healM = 0;
					  dmg = 0;
				  }
			  } else {
				  dmg = 0;
				  healH = 0;
				  healM = 0;
			  }

			  if((dmg != 0) || (healH != 0) || (healM != 0)) {
				  if(currentHP + healH > maxHP) { // reach max HP
					  healH = maxHP - currentHP;
				  }
				  usleep(1000);
				  setValue(getAddress(JunJun.currentMon, 0, 'h', PLAYER_1), currentHP + healH); // set currentHP


				  if(currentMP + healM > maxMP) { // reach max MP
					  healM = maxMP - currentMP;
				  }
				  alt_printf("healM = %x\n", healM);
				  setValue(getAddress(JunJun.currentMon, 0, 'm', PLAYER_1), currentMP + healM);


				  write(dmg);
				  usleep(1000);
				  write(healH);
				  round = 1; // switch round
				  if(dmg != 0) {
					  currentEHP -= dmg;
					  if(currentEHP <= 0 && JunE.currentMon != 2) {
						  currentEHP = 0;
						  setValue(getAddress(JunE.currentMon, 0, 'h', PLAYER_2), currentEHP);
						  JunE.currentMon++;
						  enemyMaxHP = getValue(getAddress(JunE.currentMon, 0, 'h', PLAYER_2)); // get new Enemy's max HP
						  //*enable = pokemonDecoder(JunJun, JunE);
						  alt_printf("You killed enemy's pokemon.\n");
					  } else if(currentEHP <= 0 && JunE.currentMon == 2) {
						  *enable2 = 0;
						  alt_printf("You win\n");
						  endgame = 1;
					  } else {
						  setValue(getAddress(JunE.currentMon, 0, 'h', PLAYER_2), currentEHP);
					  }
				  }
				  alt_printf("dmg = %x, healH = %x, healM = %x\n", dmg, healH, healM);
			  }
		  } else { // incoming
			  inDmg = read(); // get damage
			  usleep(500);
			  eHeal = read(); // get enemy's heal
			  alt_printf("inDmg = %x, eHeal = %x\n", inDmg, eHeal);
			  if((inDmg != 0) && (eHeal == 0)) {
				  *getattack = 1;
				  usleep(500000);
				  *getattack = 0;
				  currentHP -= inDmg;
				  if(currentHP <= 0 && JunJun.currentMon != 2){ // my pokemon is dead
					  setValue(getAddress(JunJun.currentMon, 0, 'h', PLAYER_1), 0); // set current mon's hp to 0
					  JunJun.currentMon++; // increment currentMon
					  maxHP = getValue(getAddress(JunJun.currentMon, 0, 'h', PLAYER_1));
					  maxMP = getValue(getAddress(JunJun.currentMon, 0, 'm', PLAYER_1));
					  //*enable = pokemonDecoder(JunJun, JunE);
					  alt_printf("Your pokemon is killed.\n");
				  } else if(currentHP <= 0 && JunJun.currentMon == 2){
					  *enable1 = 0;
					  *life = 0;
					  alt_printf("You lost\n");
					  endgame = 1;
				  } else {
					  setValue(getAddress(JunJun.currentMon, 0, 'h', PLAYER_1), currentHP);
				  }
				  round = 0;
			  } else if((inDmg == 0) && (eHeal != 0)) {
				  setValue(getAddress(JunE.currentMon, 0, 'h', PLAYER_2), currentEHP + eHeal); // enemy uses tango
				  round = 0;
			  } else { // enemy uses mango
				  round = 0;
			  }
		  }

	  }
  alt_printf("Game over\n");
  return 0;
}

char singlePokeDecoder(int currentMon) {
	char enableBus = 0;
	switch(currentMon) {
		case 0:
			enableBus |= 0b000001;
			return enableBus;
		case 1:
			enableBus |= 0b000010;
			return enableBus;
		case 2:
			enableBus |= 0b000100;
			return enableBus;
		case 3:
			enableBus |= 0b001000;
			return enableBus;
		case 4:
			enableBus |= 0b010000;
			return enableBus;
		case 5:
			enableBus |= 0b100000;
			return enableBus;
		default:
			return enableBus;
	}

}

// decode the key input
int keyDecoder(int key) {
	switch(key) {
		case 0b00000001:
			return 1;
		case 0b00000010:
			return 2;
		case 0b00000100:
			return 3;
		case 0b00001000:
			return 4;
		case 0b00010000:
			return 5; // tango
		case 0b00100000:
			return 6; // mango
		default :
			return 0;
	}
}

void write(char userIn) {
	//*p_data_out = 0b11111111;
	*load = 1;

	  *p_data_in = userIn;
	  //junk = alt_getchar();

	  if (1 == *load) {
		 *load = 0;
	  }
	  *transmit_enable = 1;
	  do {
		if(1 == *char_sent){
			usleep(100);
			alt_printf("Data is sent successfully.\n");
		}
	  } while (0 == *char_sent);

	  *transmit_enable = 0;
	  //usleep();
}

char read(void) {
	//int receive_f = 0;
	while (1) {
	  if(1 == *char_received){
		//usleep(RECEIVE_BAUD_WIDTH);
		return *p_data_out;
		//receive_f = 1;
	  }
	  //usleep(RECEIVE_BAUD_WIDTH);
	}
	return 0;
}


void setValue(char add, char data) {
	*addr = add;
	*read_write = 1;
	*data_in = data;
	//usleep(500);
	*read_write = 0;

}

// damage located at an address of currentMon * 20 + skillKey * 4 + 1
// cost located at an address of currentMon * 20 + skillKey * 4 + 2
// accuracy located at an address of currentMon * 20 + skillKey * 4 + 3
// pokemon No. located at an address of currentMon * 20 + 16
// pokemon's hp located at an address of currentMon * 20 + 17
// pokemon's mp located at an address of currentMon * 20 + 18

// notation brief:
// damage -- d
// cost -- c
// critical -- a
// pokemon's No. -- n
// pokemon's hp -- h
// pokemon's mp -- m
// tango's heal -- t
// tango's amount -- l
// mango's heal -- g
// mango's amount -- k
int getAddress(int currentMon, int skill, char type, int playerNo) {
	int offset = 0;
	int isSkill= 0;
	skill = skill - 1;
	if('d' == type) { // damage
		offset = 1;
		usleep(200);
		isSkill = 1;
		usleep(200);
	} else if('c' == type) { // cost
		offset = 2;
		usleep(200);
		isSkill = 1;
		usleep(200);
	} else if('a' == type) { // critical
		offset = 3;
		usleep(200);
		isSkill = 1;
		usleep(200);
	} else if('h' == type) { // hp
		offset = 16;
		usleep(200);
		isSkill = 0;
		usleep(200);
	} else if('m' == type) { //mp
		offset = 17;
		usleep(200);
		isSkill = 0;
		usleep(200);
	} else if('t' == type) { // tango's heal
		offset = 56;
		//usleep(200);
		isSkill = 0;
		//usleep(200);
	} else if('l' == type) { // tango's amount
		offset = 55;
		//usleep(200);
		isSkill = 0;
		//usleep(200);
	} else if('g' == type) { // mango's heal
		offset = 58;
		//usleep(200);
		isSkill = 0;
		//usleep(200);
	} else if('k' == type) { // mango's amount
		offset = 57;
		//usleep(200);
		isSkill = 0;
		//usleep(200);
	}

	return playerNo * 60 + currentMon * 18 + isSkill * skill * 4 + offset;
}

char getValue(char add) {
	usleep(500);
	*addr = add;
	//usleep(100);
    return *data_out;
}


char pokemonSkill(int pokemonNum, int skillNum, int type) {
	char skill[6][4][3] = {
			{{5, 0, 1}, {25, 25, 5}, {15, 10, 3}, {30, 25, 3}}, // pokemon 0
			{{5, 0, 1}, {40, 50, 4}, {30, 25, 5}, {20, 15, 5}}, // pokemon 1
			{{5, 0, 1}, {20, 15, 5}, {20, 20, 3}, {20, 25, 4}},  // pokemon 2
			{{5, 0, 1}, {30, 30, 3}, {25, 25, 3}, {15, 15, 2}}, // pokemon 3
			{{10, 0, 2}, {35, 35, 3}, {20, 20, 2}, {25, 30, 4}}, // pokemon 4
			{{10, 0, 2}, {35, 30, 4}, {25, 30, 2}, {30, 35, 3}} // pokemon 5
	};
	return skill[pokemonNum][skillNum][type];
}

/*
 * modelValue(&pokemonA, 4, 3);
   modelValue(&pokemonB, 3, 4);
   modelValue(&pokemonC, 6, 1);
   modelValue(&pokemonD, 5, 2);
   modelValue(&pokemonE, 2, 5);
   modelValue(&pokemonF, 2, 6);

 * pokemon->hp = 60 + pokemonModel.strength * 10;
 * pokemon->mp = 60 + pokemonModel.intelligence * 10;
*/
// prop: 0 -> hp, 1 -> mp
char pokemonProp (int pokemonNum, int prop) {
	char pokemonProperty[6][2] = {
			{100, 90},
			{hpmp(3), hpmp(4)},
			{hpmp(6), hpmp(1)},
			{hpmp(5), hpmp(2)},
			{hpmp(2), hpmp(5)},
			{hpmp(2), hpmp(6)},
	};
	return pokemonProperty[pokemonNum][prop];
}

int hpmp (int factor) {
	return 60 + factor * 10;
}

char items(int type, int prop) {
	char item[2][2] = {
					  {2, 50}, // tango
 					  {2, 50}  // mango
					  };
	return item[type][prop];
}

/*
typedef struct {
	char* name;
	int currentMon;
	int mon[3];
	int tg[2];
	int mg[2];
} player;
*/

player initPlayer(player plr, int mon0, int mon1, int mon2) {
	plr.mon[0] = mon0;
	plr.mon[1] = mon1;
	plr.mon[2] = mon2;
	plr.currentMon = 0;
	memAlloc(plr);
	//busyAddr -= 60;
	//memAlloc(plr);
	return plr;
}


// damage located at an address of currentMon * 20 + skillKey * 4 + 1
// cost located at an address of currentMon * 20 + skillKey * 4 + 2
// accuracy located at an address of currentMon * 20 + skillKey * 4 + 3
// pokemon No. located at an address of currentMon * 20 + 16
// pokemon's hp located at an address of currentMon * 20 + 17
// pokemon's mp located at an address of currentMon * 20 + 18
void memAlloc(player plr) {
	int i, a, b, c;
	// pokemon attributes memory allocation
	for(i = 0; i < 3; i++) {
		// skill memory allocation
		for(a = 0; a < 4; a++) {
			setValue(busyAddr + i * 18 + a * 4, 0); // pokemon No.
			//alt_printf("put plr.mon[%x].skl[%x].no %x to 0x%x\n", i, a, 0, busyAddr + i * 20 + a * 4);
			setValue(busyAddr + i * 18 + a * 4 + 1, pokemonSkill(plr.mon[i], a, 0)); // damage
			//alt_printf("put plr.mon[%x].skl[%x].damage %x to 0x%x\n", i, a, pokemonSkill(plr.mon[i], a, 0), busyAddr + i * 20 + a * 4 + 1);
			setValue(busyAddr + i * 18 + a * 4 + 2, pokemonSkill(plr.mon[i], a, 1)); // cost
			//alt_printf("put plr.mon[%x].skl[%x].cost %x to 0x%x\n", i, a, pokemonSkill(plr.mon[i], a, 1), busyAddr + i * 20 + a * 4 + 2);
			setValue(busyAddr + i * 18 + a * 4 + 3, pokemonSkill(plr.mon[i], a, 2)); // critical
			//alt_printf("put plr.mon[%x].skl[%x].critical %x to 0x%x\n", i, a, pokemonSkill(plr.mon[i], a, 2), busyAddr + i * 20 + a * 4 + 3);
		}
		// tango memory allocation

		//alt_printf("put plr.mon[%x].no %x to 0x%x\n", i, 0, busyAddr + i * 20 + 24);
		setValue(busyAddr + i * 18 + 16, pokemonProp(plr.mon[i], 0)); // hp
		//alt_printf("put plr.mon[%x].hp %x to 0x%x\n", i, pokemonProp(plr.mon[i], 0), busyAddr + i * 20 + 25);
		setValue(busyAddr + i * 18 + 17, pokemonProp(plr.mon[i], 1)); // mp
		//if(i == 0) {
			//setValue(busyAddr + i * 27 + 26, 163);
		//}
		//alt_printf("put plr.mon[%x].mp %x to 0x%x\n", i, pokemonProp(plr.mon[i], 1), busyAddr + i * 20 + 26);
	}
	setValue(busyAddr + 54, plr.currentMon); // current pokemon memory

	// tango
	setValue(busyAddr + 55, items(0, 0)); // amount
	//alt_printf("put plr.tg[%x].amount %x to 0x%x\n", b, items(0, 0), busyAddr + i * 20 + 16 + b * 2 + 1);
	setValue(busyAddr + 56, items(0, 1)); // heal
	//alt_printf("put plr.tg[%x].heal %x to 0x%x\n", b, items(0, 1), busyAddr + i * 20 + 16 + b * 2);


	// mango
	setValue(busyAddr + 57, items(1, 0)); // amount
	//alt_printf("put plr.mg[%x].amount %x to 0x%x\n", c, items(1, 0), busyAddr + i * 20 + 16 + c * 2);
	setValue(busyAddr + 58, items(1, 1)); // heal
	//alt_printf("put plr.mg[%x].heal %x to 0x%x\n", c, items(1, 1), busyAddr + i * 20 + 16 + c * 2);
	busyAddr = busyAddr + 60;
}

