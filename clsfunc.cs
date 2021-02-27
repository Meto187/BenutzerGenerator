using BenutzerGenerator_MetinDereli.Properties;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
namespace BenutzerGenerator_MetinDereli.Funktionen
{
    public class clsfunc
    {
        public FrmBenutzerGenerator frm;
        //Benutzername wird Generiert
        public void _benutzerGenerieren(FrmBenutzerGenerator frm)
        {
            //Benutzernamen und Passwort Deklariert und Convertiert auf String
            string nachname = Convert.ToString(frm.txtNachname.Text.Trim());
            string vorname = Convert.ToString(frm.txtVorname.Text.Trim());
            frm.parInVorname = frm.txtVorname.Text;
            frm.parInNachname = frm.txtNachname.Text;
            //--

            //UMLAUTE
            //--Nachname
            nachname = nachname.Replace("ä", "ae");
            nachname = nachname.Replace("Ä", "AE");
            nachname = nachname.Replace("Ö", "OE");
            nachname = nachname.Replace("ö", "oe");
            nachname = nachname.Replace("Ü", "UE");
            nachname = nachname.Replace("ü", "ue");
            nachname = nachname.Replace("ß", "ss");
            nachname = nachname.Replace("é", "e");
            //--Vorname
            vorname = vorname.Replace("Ä", "AE");
            vorname = vorname.Replace("Ö", "OE");
            vorname = vorname.Replace("ö", "oe");
            vorname = vorname.Replace("Ü", "UE");
            vorname = vorname.Replace("ü", "ue");
            vorname = vorname.Replace("ß", "ss");
            vorname = vorname.Replace("é", "e");
            //--

            //Umlaute wechseln in den 
            frm.txtVorname.Text = vorname;
            frm.txtNachname.Text = nachname;
            //--

            //Vor und nachname werden vereint
            string benutzername = nachname + vorname;
            //--

            //Benutzername wird hier erstellt durch den Vor und 
            if (benutzername.Length <= 8)
            {
                frm.parInBenutzerName = benutzername;
            }
            else if (nachname.Length > 7)
            {
                frm.parInBenutzerName = nachname.Substring(0, 7) + vorname.Substring(0, 1);
            }
            else if (nachname.Length <= 7)
            {
                frm.parInBenutzerName = benutzername.ToString().Substring(0, 8);
            }
            //--
        }
        //--

        //Passwort wird Generiert
        public void _passwortGenerieren(FrmBenutzerGenerator frm)
        {
            //Passwort werte 
            String grossbuchstaben = "QWERTZUIOPASDFGHJKLYXCVBNM";
            String kleinbuchstaben = "qwertzuiopasdfghjklyxcvbnm";
            String nummern = "12345678900";
            String sonderzeichen = "@€!$%&?*+#";
            //--

            //Variablen Zusammen 
            string alles = grossbuchstaben + kleinbuchstaben + nummern + sonderzeichen;
            //--

            //Hier wird Das Passwort erstellt durch ein 
            Char[] stringChars = new Char[10];
            Random random = new Random();
            for (int i = 0; i < stringChars.Length; i++)
            {
                stringChars[i] = alles[random.Next(alles.Length)];
                string finalystring = new string(stringChars);
                frm.parInPassWort = finalystring;
            }
            frm.rtbBenutzerDaten.Text = frm.parInBenutzerName + "         Benutzername" + "\n" + frm.parInPassWort + "           Passwort";
            //--

            //Initialisierung der Email Adresse und der Telefonnummer von der Textbox in den 
            frm.parInEmail = frm.txtEmail.Text;
            frm.parInTelefon = frm.txtTelefon.Text;
            //--
        }
        //--

        //Drawer/SlideMenu wird erstellt
        public void _drawerSlideMenu(FrmBenutzerGenerator frm)
        {
            //Drawer Menu Öffnen
            //--
            if (frm.HidenSlideMenu)
            {
                frm.pnlWidthDrawer = 250;
                frm.pnlSlideMenu.Width = frm.pnlSlideMenu.Width + 10;
                if (frm.pnlSlideMenu.Width >= frm.pnlWidthDrawer)
                {
                    frm.timeMenu.Stop();
                    frm.HidenSlideMenu = false;
                }
            }
            //--

            //Drawer Menu 
            else
            {
                frm.pnlSlideMenu.Width = frm.pnlSlideMenu.Width - 10;
                if (frm.pnlSlideMenu.Width <= 0)
                {
                    frm.timeMenu.Stop();
                    frm.HidenSlideMenu = true;
                }
            }
            //--
        }
        //--

        //DropDown Menu wird erstellt
        public void _dropDownMenu(FrmBenutzerGenerator frm)
        {
            //DropDown Menu 
            if (frm.HidenSlideDropDown)
            {
                frm.btnDropBerechtigungen.Image = Resources.icons8_collapse_arrow_26px;
                frm.pnlHeightDropDown = 211;
                frm.pnlDropdown.Height = frm.pnlDropdown.Height + 50;
                if (frm.pnlDropdown.Height >= frm.pnlHeightDropDown)
                {
                    frm.time2Dropdown.Stop();
                    frm.HidenSlideDropDown = false;
                }
            }
            //--

            //DropDown Menu 
            else
            {
                frm.btnDropBerechtigungen.Image = Resources.icons8_expand_arrow_26px;
                frm.pnlDropdown.Height = frm.pnlDropdown.Height - 50;
                if (frm.pnlDropdown.Height <= 47)
                {
                    frm.time2Dropdown.Stop();
                    frm.HidenSlideDropDown = true;
                }
            }
            //--
        }
        //--

        public void _uGRPBerechtigungee(FrmBenutzerGenerator frm)
        {
            //Berechtigungen von den RadioButton auf die Parameter Initialisieren
            if (frm.rbBerechtigung1.Checked == true)
            {
                frm.parInUGRPId = 24;
            }
            //--
            if (frm.rbBerechtigung2.Checked == true)
            {
                frm.parInUGRPId = 66;
            }
            //--
            if (frm.rbBerechtigung3.Checked == true)
            {
                frm.parInUGRPId = 77;
            }
            //--
            if (frm.rbBerechtigung4.Checked == true)
            {
                frm.parInUGRPId = 236;
            }
            //--
            if (frm.rbBerechtigung5.Checked == true)
            {
                frm.parInUGRPId = 369;
            }
            //--
        }
        
    }
}
