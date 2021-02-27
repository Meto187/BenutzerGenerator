using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;


namespace BenutzerGenerator_MetinDereli
{

    public class clsFehlerMeldungen
    {
        public void _fehlerMelungBenutzerErstellen(FrmBenutzerGenerator frm)
        {
            MessageBox.Show("Um den Benutzernamen zu erstellen bitte Vor und Nachnamen eintragen");
        }
        public void _benutzerErstellenAbbruch(FrmBenutzerGenerator frm)
        {
            // Mitteilung Wenn es der Benutzer nicht erstellt werden 
            MessageBox.Show("Error !!! 502 Benutzer konnte nicht erstellt werden");
            //--
        }
        public void _BenutzerInsert(FrmBenutzerGenerator frm)
        {
            //BenutzerNamen fehler meldung
            if (frm.parInBenutzerName == "" | frm.parInBenutzerName == null)
            {
                MessageBox.Show("bitte bevor sie einen Benutzer Generieren möchten geben sie erst den Vor und Nachnamen " +
                                "ein und bestätigen sie es mit dem Button ''Benutzer Erstellen''auswählen"
                                );
            }
            //--
            
            // GruppenBerechtigungen Fehler meldung
            else if (frm.parInUGRPId == 0)
            {
                MessageBox.Show("Bitte eine Berechtigung auswählen");
            }
            //--

            // Nachnamen Fehler meldung
            else if (frm.parInNachname == "" | frm.parInNachname == null)
            {
                MessageBox.Show("Bitte geben sie ihren Nachnamen ein");
            }
            //--
            // Vornamen Fehler meldung
            else if (frm.parInVorname == ""| frm.parInVorname == null)
            {
                MessageBox.Show("Bitte geben sie ihren Vornamen ein");
            }
            //--

            if (frm.parOutResult != 10)
            {
                MessageBox.Show("Benutzer wurde nicht Erstellt");
            }
        }
    }
}
