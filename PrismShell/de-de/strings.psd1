# This is where the strings go, that are written by
# Write-PSFMessage, Stop-PSFFunction or the PSFramework validation scriptblocks
@{
	'AddPrismProfile.ProfileExistsError'     = 'Profil mit ID {0} existiert schon auf {1}. Mit -Force überschreiben.'
	'AddPrismProfile.NotImplemented'         = "Aktuell können keine neuen Profile hinzugefügt werden. Wenn du eine Lösung findest, öffne einen PR bei github.com/nyanhp/prismshell"
	'FindPrismPrinter.AutoDiscoDisabled'     = 'Auto-discovery nicht aktiviert. Gebe Standarddrucker zurück'
	'FindPrismPrinter.AutoDiscoEnabled'      = 'Benutze Auto-discovery - lese ARP Cache'
	'FindPrismPrinter.HashtagSad'            = 'Kein Drucker gefunden - bitte pinge ihn ein mal an.'
	'FindPrismPrinter.MultiplePrintersFound' = 'Es wurde mehr als ein Drucker gefunden. Bitte sieh dir die Liste der Drucker gut an, und wähle den richtigen aus.'
	'GetPrismFile.DiscoveryStarted'          = 'Suche Dateien auf {0}'
	'GetPrismFile.FilterName'                = 'Filtere Dateien auf {0} anhand ihres Namens mit Filter {1}.'
	'GetPrismProfile.FilterIndex'            = 'Index {2} entspricht keinem Profil auf {0} mit Indexfilter {1}'
	'NewPrismSession.CreateAuthCookie'       = 'Erstelle auth cookie für {0} mit Wert {1}'
	'NewPrismSession.NoMacAddress'           = 'Es wurde keine MAC-Adresse gefunden zu {0}. Keine Arme, keine Kekse.'
	'RemovePrismFile.Removing'               = 'Versuche {1} von {0} zu entfernen.'
	'ResumePrismPrint.NotResuming'           = 'Kann Druck nicht wiederaufnehmen. Drucker {0} ist gerade Idle'
	'StartPrismPrint.ProfileMissing'         = 'Harzprofil {1} existiert auf {0} nicht. Versuch es mit "Get-PrismProfile -ComputerName {0}" um zu sehen, welche Profile es gibt'
	'StartPrismPrint.FileNotFound'           = 'Datei {1} konnte auf SD Karte in {0} nicht gefunden werden. Folgende Dateien wurden gefunden: {2}'
	'StartPrismPrint.Starting'               = 'Drucke {1} auf {0} mit Profil ID {2}'
	'StopPrismPrint.NotStopping'             = 'Konnte Druck nicht abbrechen. Drucker {0} ist gerade Idle'
	'StopPrismPrint.AttemptStop'             = 'Versuche aktiven Druck auf {0} abzubrechen.'
	'SuspendPrismPrint.NotSuspending'        = 'Konnte Druck nicht pausieren. Drucker {0} ist gerade Idle'
	'SuspendPrismPrint.AttemptPause'         = 'Versuche aktiven Druck auf {0} zu pausieren'

	'GetArpCache.DnsLookupFailed'            = 'DNS lookup von {0} fehlgeschlagen. Kann die ARP-Tabelle nicht zuverlässig filtern, um Auth cookie zu erstellen.'
	'GetArpCache.AddingEntry'                = 'Füge Eintrag {0} zum ARP cache hinzu'
	'GetArpCache.Filtering'                  = 'Filtere cache nach {0}'
	'GetArpCache.MalformedMac'               = 'Unpassende MAC in Eintrag {0}, {1}'
}