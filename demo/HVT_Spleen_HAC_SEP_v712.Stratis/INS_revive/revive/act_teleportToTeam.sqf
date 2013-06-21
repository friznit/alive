/*
 * Teleport to teammate action
 * 
 * Copyleft 2013 naong
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
 
[player, player] call INS_REV_FNCT_onKilled;
player removeAction INS_REV_GVAR_teleportToTeam;
player setVariable ["INS_REV_PVAR_isTeleport", true, true];
