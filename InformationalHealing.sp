#include <sourcemod>

ConVar g_enablePlugin;

public Plugin myinfo = 
{
	name = "Informational Healing",
	author = "Sweats",
	description = "A test plugin that displays healing events in the chat box",
	url = " "

};

public void OnPluginStart()
{
	HookEvent("heal_begin", Event_HealBegin); // post for these events. Our event callback will get executed after the event fires.
	HookEvent("heal_success", Event_HealSuccess);
	HookEvent("heal_interrupted", Event_HealInterrupted);

	g_enablePlugin = CreateConVar("g_InformationalPluginEnable", "1", "Enables/Disables the plugin", FCVAR_NOTIFY, true, 0.0, true, 1.0);
}

public void Event_HealBegin(Event event, const char[] name, bool dontBroadcast)
{
	if (GetConVarBool(g_enablePlugin))
	{
		int userid = GetClientOfUserId(event.GetInt("userid"));
		int subject = GetClientOfUserId(event.GetInt("subject"));

		char useridName[MAX_NAME_LENGTH];
		char subjectName[MAX_NAME_LENGTH];

		GetClientName(userid, useridName, sizeof(useridName));
		GetClientName(subject, subjectName, sizeof(subjectName));

		if (StrEqual(useridName, subjectName, false))
		{
			PrintToChatAll("Player %s has begun healing themselves...", useridName);
		}

		else
		{
			PrintToChatAll("Player %s is now healing %s...", useridName, subjectName);
		}
	}
}

public void Event_HealSuccess(Event event, const char[] name, bool dontBroadcast)
{
	if (GetConVarBool(g_enablePlugin))
	{
		int userid = GetClientOfUserId(event.GetInt("userid"));
		int subject = GetClientOfUserId(event.GetInt("subject"));
		int AmountHealed = event.GetInt("health_restored");

		char useridName[MAX_NAME_LENGTH];
		char subjectName[MAX_NAME_LENGTH];

		GetClientName(userid, useridName, sizeof(useridName));
	 	GetClientName(subject, subjectName, sizeof(subjectName));

		if (StrEqual(useridName, subjectName, false))
		{
			PrintToChatAll("Player %s healed themselves for %d health!", useridName, AmountHealed);
		}

		else
		{
			PrintToChatAll("Player %s healed player %s for %d health!", useridName, subjectName, AmountHealed);
		}
	}
}

public void Event_HealInterrupted(Event event, const char[] name, bool dontBroadcast)
{
	if (GetConVarBool(g_enablePlugin))
	{
		int userid = GetClientOfUserId(event.GetInt("userid"));
		int subject = GetClientOfUserId(event.GetInt("subject"));

		char useridName[MAX_NAME_LENGTH];
		char subjectName[MAX_NAME_LENGTH];

		GetClientName(userid, useridName, sizeof(useridName));
		GetClientName(subject, subjectName, sizeof(subjectName));

		if (StrEqual(useridName, subjectName, false))
		{
			PrintToChatAll("Player %s healing to self was interrupted!", useridName);
		}

		else
		{
			PrintToChatAll("Player %s healing to %s was interrupted!", useridName, subjectName);
		}
	}
}
