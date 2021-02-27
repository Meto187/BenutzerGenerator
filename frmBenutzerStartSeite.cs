using BenutzerGenerator_MetinDereli.Properties;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BenutzerGenerator_MetinDerelii
{
    public partial class FrmBenutzerGenerator : Form
    {
        //Einbinden der methoden aus den Klassen
        public clsFehlerMeldungen clsFehler = new clsFehlerMeldungen();
        //--
        public Funktionen.clsfunc clsfunc = new Funktionen.clsfunc();
        //--

        //Primary Keys der verschiedenen Tabellen deklariert
        public decimal parInUSERId = 0;
        public decimal parInUGRPId = 0;
        public decimal parInANSFId = 0;
        //--

        // eingabe Parameter deklariert 
        public string parInVorname;
        public string parInNachname;
        public string parInTelefon;
        public string parInEmail;
        public string parInPassWort;
        public string parInBenutzerKennung;
        public string parInBenutzerName;
        //--

        // ausgabe Parameter deklarieren
        public string parOutInfo = "";
        public string parOutMeldung = "";
        public decimal? parOutResult = 0;
        //--

        // Drawer Bool Initialisiert
        public bool HidenSlideMenu = true;
        public bool HidenSlideDropDown = true;
        //--

        // Panel Drawer die breiten größe Deklariert
        public int pnlWidthDrawer;
        public int pnlHeightDropDown;
        //--

        public FrmBenutzerGenerator()
        {
            InitializeComponent();
            // um die anwendung in der mitte des bildschirmes anzuzeigen
            this.StartPosition = FormStartPosition.CenterScreen;
            pnlSlideMenu.Width = pnlWidthDrawer;
            pnlDropdown.Height = pnlHeightDropDown;
            //--
        }

        private void btnBenutzerErstellen_Click(object sender, EventArgs e)
        {
            try
            {
                //Hinweis Meldungen
                if (string.IsNullOrEmpty(txtVorname.Text) || string.IsNullOrEmpty(txtNachname.Text))
                {
                    clsFehler._fehlerMelungBenutzerErstellen(this);
                }
                //--
                else
                {
                    //Methode für die Benutzer Generierung
                    clsfunc._benutzerGenerieren(this);
                    //--

                    //Methode für die Passwort Generierung
                    clsfunc._passwortGenerieren(this);
                    //--
                }
            }
            catch (Exception)
            {
                clsFehler._benutzerErstellenAbbruch(this);
            }
        }

        private void timeMenu_Tick(object sender, EventArgs e)
        {
            clsfunc._drawerSlideMenu(this);
        }

        private void BtnStartMenu_Click(object sender, EventArgs e)
        {
            // Starten des Drawer (SlideMenu)
            timeMenu.Start();
            //--
        }

        private void FrmBenutzerGenerator_Load(object sender, EventArgs e)
        {
            // Einbindung einer Tabelle in die DataGridView
            this._USERTableAdapter.Fill(this.ds_User._USER);
        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            // Schließen der Anwendung
            Application.Exit();
            //--
        }

        private void btnHide_Click(object sender, EventArgs e)
        {
            // Anwendung Minimieren
            this.WindowState = FormWindowState.Minimized;
            //--
        }

        private void btnDropBerechtigungen_Click(object sender, EventArgs e)
        {
            // Starten des DropDown Menu 
            time2Dropdown.Start();
            //--
        }

        private void time2Dropdown_Tick(object sender, EventArgs e)
        {
            // Funktion der das DropDown Menu Öffnet und schließt
            clsfunc._dropDownMenu(this);
            //--
        }

        private void btnBenutzerInsert_Click(object sender, EventArgs e)
        {
            //eine Info für die Letzte erstellung eines 
            lblLtztBenutzerName.Text = "BenutzerName:\n" + parInBenutzerKennung;
            lblPswrtLetzteErstellung.Text = "Passwort:\n" + parInPassWort;
            lblLtztEmail.Text = "E-mail Adresse:\n" + parInEmail;
            lblLtztTelefon.Text = "Telefon:\n" + parInTelefon;
            //--
            
            //Methode Für die einbindungen der Berechtigungen an den RadioButton
            clsfunc._uGRPBerechtigungee(this);
            //--

            // BenutzerName in die Parameter Einbinden
            parInBenutzerKennung = txtVorname.Text.Trim() + " " + txtNachname.Text.Trim();
            //--

            //Benutzer Daten einbinden in die StoredProcedure
            DataSets.ds_UserTableAdapters._USERTableAdapter ta_User = new DataSets.ds_UserTableAdapters._USERTableAdapter();
            //--

            //Fehler Meldungen
            if (parInBenutzerName == "" | parInBenutzerName == null |
                parInBenutzerKennung == "" | parInBenutzerKennung == null |
                parInPassWort == "" | parInPassWort == null |
                parInEmail == "" | parInEmail == null |
                parInTelefon == "" | parInTelefon == null |
                parInUGRPId == 0)
            {
                clsFehler._BenutzerInsert(this);
            }
            //--
            else
            {
                // Table Adapter mit Parameter Binden
                ta_User.Metin_BenutzerGenerator(parInUSERId, parInBenutzerKennung, parInPassWort, parInBenutzerName, parInEmail,
                                                parInTelefon, parInANSFId, parInUGRPId, ref parOutInfo, ref parOutMeldung, ref parOutResult);
                // switch case anweisung case 10 = ist gruen
                switch (parOutResult)
                {
                    case 10:
                    default:
                        break;
                }
                if (parOutResult != 10)
                {
                    MessageBox.Show(parOutMeldung.Trim());
                }
                //tableadapter schließen
                ta_User.Dispose();
                // aktualisieren der DataGridView
                this._USERTableAdapter.Fill(this.ds_User._USER);
                //--
            }
        }
    }
}
